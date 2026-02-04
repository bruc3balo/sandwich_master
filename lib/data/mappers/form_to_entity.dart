import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/forms/sandwich_form.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';

extension IngredientFormToEntity on IngredientForm {
  Ingredient toEntity({IngredientId? customId}) {
    final effectiveId = customId ?? id ?? IngredientId(DateTime.now().microsecondsSinceEpoch.toString());
    
    switch (type) {
      case IngredientType.bread:
        return Bread(
          id: effectiveId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.protein:
        return Protein(
          id: effectiveId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.topping:
        return Topping(
          id: effectiveId,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.sauce:
        return Sauce(
          id: effectiveId,
          name: name,
          description: description,
          price: price,
        );
    }
  }
}

extension SandwichFormToEntity on SandwichForm {
  Sandwich toEntity({SandwichId? customId}) {
    final effectiveId = customId ?? id ?? SandwichId(DateTime.now().microsecondsSinceEpoch.toString());
    
    return Sandwich(
      id: effectiveId,
      name: name,
      bread: bread,
      proteins: proteins,
      toppings: toppings,
      sauces: sauces,
    );
  }
}
