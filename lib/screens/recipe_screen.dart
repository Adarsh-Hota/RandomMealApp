import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_app/modals/meal_modal.dart';
import 'package:random_meal_app/provider/meal_provider.dart';
import 'package:random_meal_app/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  Future<void> _launchYoutubeUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MealModal> meal = ref.watch(mealProvider);

    return Scaffold(
        body: meal.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(err.toString())),
      data: (recipe) {
        recipe.ingredients.removeWhere((element) => element.name == '');
        return CustomScrollView(
          slivers: [
            //image
            SliverToBoxAdapter(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (0.40),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: recipe.imageUrl == ''
                        ? const AssetImage('assets/images/no_image_found.png')
                        : NetworkImage(recipe.imageUrl) as ImageProvider,
                    fit: recipe.imageUrl == '' ? BoxFit.contain : BoxFit.cover,
                  ),
                ),
              ),
            ),

            //heading section
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //heading text
                      Text(
                        recipe.name,
                        style: textStyle(35, Colors.black, FontWeight.w700,
                            fontType: 5),
                      ),

                      //space
                      const SizedBox(
                        height: 5,
                      ),

                      //tags section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //first tag
                          Row(
                            children: [
                              Chip(
                                backgroundColor: Colors.yellow,
                                label: SizedBox(
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      recipe.category,
                                      style: textStyle(
                                          18, Colors.black, FontWeight.w600,
                                          fontType: 3),
                                    ),
                                  ),
                                ),
                              ),

                              //space in between
                              const SizedBox(
                                width: 10,
                              ),

                              //second tag
                              Chip(
                                backgroundColor: Colors.deepOrangeAccent,
                                label: SizedBox(
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      recipe.area,
                                      style: textStyle(
                                          18, Colors.black, FontWeight.w600,
                                          fontType: 3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Youtube button
                          SizedBox(
                            height: 35,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              onPressed: () =>
                                  _launchYoutubeUrl(recipe.youtubeUrl),
                              child: Center(
                                child: Text(
                                  'Youtube',
                                  style: textStyle(
                                      18, Colors.white, FontWeight.w600,
                                      fontType: 3),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      //space
                      const SizedBox(
                        height: 15,
                      ),

                      //Ingredients heading
                      Text(
                        'Ingredients',
                        style: textStyle(25, Colors.black, FontWeight.w600,
                            fontType: 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //images of ingredients
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: recipe.ingredients.map((element) {
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 8, bottom: 8, right: 10),
                        child: Column(
                          children: [
                            Image(
                              width: 100,
                              height: 100,
                              image: NetworkImage(
                                  'https://www.themealdb.com/images/ingredients/${element.name}-Small.png'),
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(element.name,
                                style: textStyle(
                                  18,
                                  Colors.black,
                                  FontWeight.w700,
                                  fontType: 4,
                                )),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(element.measure,
                                style: textStyle(
                                  16,
                                  Colors.grey,
                                  FontWeight.w700,
                                  fontType: 4,
                                )),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            //Instructions section
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1.5)),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 12,
                  bottom: 8,
                ),
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Instructions',
                        style: textStyle(25, Colors.black, FontWeight.w700,
                            fontType: 1)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      recipe.instructions,
                      style: textStyle(18, Colors.black, FontWeight.w500,
                          fontType: 3),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
