import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:random_meal_app/modals/meal_modal.dart';
import 'package:random_meal_app/utils.dart';

class MealRepository {
  //parsing in a different isolate
  Future<MealModal> parseInBackground(String body) {
    return compute(parse, body);
  }

  MealModal parse(String body) {
    final encodedJson = jsonDecode(body);
    return MealModal.fromJson(encodedJson);
  }

  Future<MealModal> getMeal() async {
    String url = urlEndpoint;
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return parseInBackground(response.body);
  }
}
