import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class DeleteIngredient {
  final IngredientRepository repository;

  DeleteIngredient(this.repository);

  Future<TaskResult<void>> execute(IngredientId id) async {
    return await repository.deleteIngredient(id);
  }
}
