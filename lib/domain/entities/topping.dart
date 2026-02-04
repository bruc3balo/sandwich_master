import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';

class Topping extends Ingredient {
  const Topping({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.image,
  }) : super(type: IngredientType.topping);
}
