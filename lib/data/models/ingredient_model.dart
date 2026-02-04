import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:sandwich_master/data/models/ingredient_type_model.dart';

part 'ingredient_model.g.dart';

@HiveType(typeId: 0)
class IngredientModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final IngredientTypeModel type;

  @HiveField(5)
  final Uint8List? image;

  IngredientModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    this.image,
  });
}
