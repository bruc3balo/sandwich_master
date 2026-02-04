import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class AddIngredient {
  final IngredientRepository repository;

  AddIngredient(this.repository);

  Future<TaskResult<Ingredient>> execute(CreateIngredientForm form) async {
    return await repository.addIngredient(form);
  }
}


