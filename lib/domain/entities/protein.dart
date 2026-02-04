import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';

class Protein extends Ingredient {
  const Protein({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.image,
  }) : super(type: IngredientType.protein);
}
