import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/repositories/ingredient_repository.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetIngredientByIdUseCase {
  final IngredientRepository repository;

  GetIngredientByIdUseCase(this.repository);

  Future<TaskResult<Ingredient?>> execute(IngredientId id) async {
    return await repository.getIngredientById(id);
  }
}
