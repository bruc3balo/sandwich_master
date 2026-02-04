import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteIngredientUseCase {
  final IngredientRepository repository;

  DeleteIngredientUseCase(this.repository);

  Future<TaskResult<void>> execute(IngredientId id) async {
    return await repository.deleteIngredient(id);
  }
}
