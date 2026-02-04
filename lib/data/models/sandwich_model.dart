import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/entities/bread.dart';
import 'package:sandwich_master/domain/entities/protein.dart';
import 'package:sandwich_master/domain/entities/topping.dart';
import 'package:sandwich_master/domain/entities/sauce.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';

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

  @HiveField(6)
  final Uint8List? image;

  SandwichModel({
    required this.id,
    required this.name,
    required this.bread,
    required this.proteins,
    required this.toppings,
    required this.sauces,
    this.image,
  });

}
