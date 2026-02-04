import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:sandwich_master/data/data_sources/ingredient/ingredient_data_source.dart';
import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

@LazySingleton(as: IngredientDataSource)
class HiveIngredientDataSource implements IngredientDataSource {
  final Box<IngredientModel> _box;

  HiveIngredientDataSource(this._box);

  @override
  Future<TaskResult<List<IngredientModel>>> getAll(PageRequest request) async {
    try {
      final keys = _box.keys;
      
      final paginatedKeys = keys.skip(request.offset).take(request.limit);
      
      final models = paginatedKeys
          .map((key) => _box.get(key))
          .whereType<IngredientModel>()
          .toList();

      return Success(data: models);
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to fetch ingredients: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<IngredientModel?>> getById(String id) async {
    try {
      final model = _box.get(id);
      return Success(data: model);
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to fetch ingredient by id: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<IngredientModel>> create(IngredientModel ingredient) async {
    try {
      await _box.put(ingredient.id, ingredient);
      return Success(data: ingredient, message: 'Ingredient created successfully');
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to create ingredient: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<IngredientModel>> update(IngredientModel ingredient) async {
    try {
      if (!_box.containsKey(ingredient.id)) {
        return const Failure(message: 'Ingredient not found');
      }
      await _box.put(ingredient.id, ingredient);
      return Success(data: ingredient, message: 'Ingredient updated successfully');
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to update ingredient: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<void>> delete(String id) async {
    try {
      if (!_box.containsKey(id)) {
        return const Failure(message: 'Ingredient not found');
      }
      await _box.delete(id);
      return const Success(data: null, message: 'Ingredient deleted successfully');
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to delete ingredient: $e', trace: stackTrace);
    }
  }
}


