import 'package:sandwich_master/domain/forms/ingredient_form.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

abstract class IngredientRepository {
  Future<TaskResult<List<Ingredient>>> getIngredients(PageRequest request);
  Future<TaskResult<Ingredient?>> getIngredientById(IngredientId id);
  Future<TaskResult<Ingredient>> addIngredient(CreateIngredientForm form);
  Future<TaskResult<Ingredient>> updateIngredient(UpdateIngredientForm form);
  Future<TaskResult<void>> deleteIngredient(IngredientId id);
}