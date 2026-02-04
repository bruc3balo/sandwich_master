import 'package:injectable/injectable.dart';
import 'package:sandwich_master/data/data_sources/ingredient/ingredient_data_source.dart';
import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/data/mappers/entity_to_local.dart';
import 'package:sandwich_master/data/mappers/local_to_entity.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/forms/ingredient_form.dart';
import 'package:sandwich_master/domain/repositories/ingredient_repository.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';

@LazySingleton(as: IngredientRepository)
class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientDataSource _dataSource;

  IngredientRepositoryImpl(this._dataSource);

  @override
  Future<TaskResult<List<Ingredient>>> getIngredients(PageRequest request) async {
    try {
      final result = await _dataSource.getAll(request);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final models):
          final ingredients = models.map((m) => m.toEntity).toList();
          return Success(data: ingredients);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error fetching ingredients: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<Ingredient?>> getIngredientById(IngredientId id) async {
    try {
      final result = await _dataSource.getById(id.value);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final model):
          final ingredient = model?.toEntity;
          return Success(data: ingredient);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error fetching ingredient by id: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<Ingredient>> addIngredient(CreateIngredientForm form) async {
    try {
      final id = IngredientId(DateTime.now().microsecondsSinceEpoch.toString());
      final ingredientEntity = Ingredient.fromCreateForm(id, form);
      
      final result = await _dataSource.create(ingredientEntity.toLocal);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final createdModel):
          final ingredient = createdModel.toEntity;
          return Success(data: ingredient);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error adding ingredient: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<Ingredient>> updateIngredient(UpdateIngredientForm form) async {
    try {
      final existingResult = await _dataSource.getById(form.id.value);
      
      switch (existingResult) {
        case Failure(message: final msg):
          return Failure(message: 'Failed to fetch existing ingredient for update: $msg');
        case Success(data: final existingModel):
          if (existingModel == null) {
            return const Failure(message: 'Ingredient not found');
          }

          final existingIngredient = existingModel.toEntity;
          final updatedIngredientEntity = Ingredient.fromUpdateForm(form, existingIngredient);
          
          final result = await _dataSource.update(updatedIngredientEntity.toLocal);
          switch (result) {
            case Failure(message: final msg, trace: final trace):
              return Failure(message: msg, trace: trace);
            case Success(data: final savedModel):
              final ingredient = savedModel.toEntity;
              return Success(data: ingredient);
          }
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error updating ingredient: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<void>> deleteIngredient(IngredientId id) async {
    try {
      final result = await _dataSource.delete(id.value);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success():
          return const Success(data: null);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error deleting ingredient: $e', trace: stackTrace);
    }
  }

}




