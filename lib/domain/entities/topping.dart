import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';

class Topping extends Ingredient {
  const Topping({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
  }) : super(type: IngredientType.topping);
}
