import 'package:sandwich_master/domain/entities/bread.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';
import 'package:sandwich_master/domain/entities/protein.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/entities/sauce.dart';
import 'package:sandwich_master/domain/entities/topping.dart';
import 'package:sandwich_master/domain/forms/ingredient_form.dart';
import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';

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
