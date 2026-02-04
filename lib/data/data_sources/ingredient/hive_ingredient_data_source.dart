import 'package:hive/hive.dart';
import 'package:form_ni_gani/data/data_sources/ingredient/ingredient_data_source.dart';
import 'package:form_ni_gani/data/models/ingredient_model.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class HiveIngredientDataSource implements IngredientDataSource {
  final Box<IngredientModel> _box;

  HiveIngredientDataSource(this._box);

  @override
  Future<TaskResult<List<IngredientModel>>> getAll(PageRequest request) async {
    try {
      final models = _box.values.toList();

      // Sort by name by default
      models.sort((a, b) => a.name.compareTo(b.name));

      final start = request.offset;
      final end = (request.offset + request.limit).clamp(0, models.length);

      if (start >= models.length) {
        return const Success(data: [], message: 'No ingredients found for this page');
      }

      final paginatedModels = models.sublist(start, end);

      return Success(data: paginatedModels);
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


