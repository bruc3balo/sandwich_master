import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';

class Bread extends Ingredient {
  const Bread({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.image,
  }) : super(type: IngredientType.bread);
}
