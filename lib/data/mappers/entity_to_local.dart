import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/data/models/sandwich_model.dart';
import 'package:sandwich_master/data/mappers/ingredient_type_mapper.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';

extension IngredientToLocal on Ingredient {
  IngredientModel get toLocal {
    return IngredientModel(
      id: id.value,
      name: name,
      description: description,
      price: price,
      type: type.toLocal,
      image: image,
    );
  }
}

extension SandwichToLocal on Sandwich {
  SandwichModel get toLocal {
    return SandwichModel(
      id: id.value,
      name: name,
      bread: bread.toLocal,
      proteins: proteins.map((p) => p.toLocal).toList(),
      toppings: toppings.map((t) => t.toLocal).toList(),
      sauces: sauces.map((s) => s.toLocal).toList(),
      image: image,
    );
  }
}
