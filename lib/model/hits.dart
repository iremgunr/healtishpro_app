import 'package:healtish_app/model/recipe_model.dart';

class Hits {
  RecipeModel recipeModel;

  Hits({this.recipeModel});

  factory Hits.fromMap(Map<String, dynamic> parsedJson) {
    return Hits(recipeModel: RecipeModel.fromMap(parsedJson["recipe"]));
  }
}
