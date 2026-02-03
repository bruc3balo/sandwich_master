import 'package:form_ni_gani/data/models/ingredient_model.dart';
import 'package:form_ni_gani/data/models/ingredient_type_model.dart';
import 'package:form_ni_gani/data/models/sandwich_model.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';
import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';

extension IngredientModelToEntity on IngredientModel {
  Ingredient get toEntity {
    final ingredientId = IngredientId(id);
    switch (type) {
      case IngredientTypeModel.bread:
        return Bread(
          id: ingredientId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientTypeModel.protein:
        return Protein(
          id: ingredientId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientTypeModel.topping:
        return Topping(
          id: ingredientId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientTypeModel.sauce:
        return Sauce(
          id: ingredientId,
          name: name,
          description: description,
          price: price,
        );
    }
  }
}

extension SandwichModelToEntity on SandwichModel {
  Sandwich get toEntity {
    return Sandwich(
      id: SandwichId(id),
      name: name,
      bread: bread.toEntity as Bread,
      proteins: proteins.map((p) => p.toEntity as Protein).toList(),
      toppings: toppings.map((t) => t.toEntity as Topping).toList(),
      sauces: sauces.map((s) => s.toEntity as Sauce).toList(),
    );
  }
}
