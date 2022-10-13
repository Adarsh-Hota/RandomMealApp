import 'package:random_meal_app/modals/ingredient.dart';

class MealModal {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final String youtubeUrl;
  final List<Ingredient> ingredients;

  MealModal(
    this.id,
    this.name,
    this.category,
    this.area,
    this.instructions,
    this.imageUrl,
    this.youtubeUrl,
    this.ingredients,
  );

  factory MealModal.fromJson(Map<String, dynamic> json) {
    return MealModal(
      json['meals'][0]['idMeal'] ?? '',
      json['meals'][0]['strMeal'] ?? '',
      json['meals'][0]['strCategory'] ?? '',
      json['meals'][0]['strArea'] ?? '',
      json['meals'][0]['strInstructions'] ?? '',
      json['meals'][0]['strMealThumb'] ?? '',
      json['meals'][0]['strYoutube'] ?? '',
      List<Ingredient>.generate(
          20,
          (int index) => Ingredient(
              json['meals'][0]['strIngredient${index + 1}'],
              json['meals'][0]['strMeasure${index + 1}'])),
    );
  }
}
