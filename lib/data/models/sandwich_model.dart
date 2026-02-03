import 'package:hive/hive.dart';
import 'package:form_ni_gani/data/models/ingredient_model.dart';
import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';

part 'sandwich_model.g.dart';

@HiveType(typeId: 1)
class SandwichModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final IngredientModel bread;

  @HiveField(3)
  final List<IngredientModel> proteins;

  @HiveField(4)
  final List<IngredientModel> toppings;

  @HiveField(5)
  final List<IngredientModel> sauces;

  SandwichModel({
    required this.id,
    required this.name,
    required this.bread,
    required this.proteins,
    required this.toppings,
    required this.sauces,
  });

  factory SandwichModel.fromEntity(Sandwich entity) {
    return SandwichModel(
      id: entity.id.value,
      name: entity.name,
      bread: IngredientModel.fromEntity(entity.bread),
      proteins: entity.proteins.map((p) => IngredientModel.fromEntity(p)).toList(),
      toppings: entity.toppings.map((t) => IngredientModel.fromEntity(t)).toList(),
      sauces: entity.sauces.map((s) => IngredientModel.fromEntity(s)).toList(),
    );
  }

  Sandwich toEntity() {
    return Sandwich(
      id: SandwichId(id),
      name: name,
      bread: bread.toEntity() as Bread,
      proteins: proteins.map((p) => p.toEntity() as Protein).toList(),
      toppings: toppings.map((t) => t.toEntity() as Topping).toList(),
      sauces: sauces.map((s) => s.toEntity() as Sauce).toList(),
    );
  }
}
