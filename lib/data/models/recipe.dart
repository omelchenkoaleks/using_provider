import 'package:equatable/equatable.dart';
import 'models.dart';

class Recipe extends Equatable {
  // Recipe properties for the recipe text: label, image and url. id is not final so can update it.
  int? id;
  final String? label;
  final String? image;
  final String? url;
  // A list of ingredients that the recipe contains along with its calories, weight and time to cook.
  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  // A constructor with all fields except ingredients, which will add later.
  Recipe(
      {this.id,
      this.label,
      this.image,
      this.url,
      this.calories,
      this.totalWeight,
      this.totalTime});

  // Equatable properties, which will use for comparison.
  @override
  List<Object?> get props =>
      [label, image, url, calories, totalWeight, totalTime];
}
