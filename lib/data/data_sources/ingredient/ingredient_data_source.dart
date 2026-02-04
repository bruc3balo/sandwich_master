import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

abstract class IngredientDataSource {
  Future<TaskResult<List<IngredientModel>>> getAll(PageRequest request);
  Future<TaskResult<IngredientModel?>> getById(String id);
  Future<TaskResult<IngredientModel>> create(IngredientModel ingredient);
  Future<TaskResult<IngredientModel>> update(IngredientModel ingredient);
  Future<TaskResult<void>> delete(String id);
}