import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_app/provider/meal_provider.dart';
import 'package:random_meal_app/screens/recipe_screen.dart';
import 'package:random_meal_app/utils.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            height: MediaQuery.of(context).size.height * (0.45),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.80),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Feeling hungry?',
                  style: textStyle(30, Colors.black, FontWeight.w700),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {
                    ref.refresh(mealProvider);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => RecipeScreen())));
                  },
                  child: Text(
                    'Show a recipe',
                    style: textStyle(
                      22,
                      Colors.black,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
