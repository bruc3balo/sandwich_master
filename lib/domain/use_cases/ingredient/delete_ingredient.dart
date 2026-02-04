import 'package:sandwich_master/domain/repositories/ingredient_repository.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteIngredientUseCase {
  final IngredientRepository repository;

  DeleteIngredientUseCase(this.repository);

  Future<TaskResult<void>> execute(IngredientId id) async {
    return await repository.deleteIngredient(id);
  }
}
