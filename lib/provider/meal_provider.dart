import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_app/modals/meal_modal.dart';
import 'package:random_meal_app/repository/meal_repository.dart';

final mealProvider = FutureProvider<MealModal>((ref) {
  return MealRepository().getMeal();
});
