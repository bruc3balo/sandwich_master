import 'package:hive/hive.dart';

part 'ingredient_type_model.g.dart';

@HiveType(typeId: 2)
enum IngredientTypeModel {
  @HiveField(0)
  bread,
  @HiveField(1)
  protein,
  @HiveField(2)
  topping,
  @HiveField(3)
  sauce,
}
