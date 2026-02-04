import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class UpdateIngredient {
  final IngredientRepository repository;

  UpdateIngredient(this.repository);

  Future<TaskResult<Ingredient>> execute(UpdateIngredientForm form) async {
    return await repository.updateIngredient(form);
  }
}


