import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';

class Sauce extends Ingredient {
  const Sauce({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.image,
  }) : super(type: IngredientType.sauce);
}
