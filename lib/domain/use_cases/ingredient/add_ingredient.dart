import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class AddIngredientUseCase {
  final IngredientRepository repository;

  AddIngredientUseCase(this.repository);

  Future<TaskResult<Ingredient>> execute(CreateIngredientForm form) async {
    return await repository.addIngredient(form);
  }
}


