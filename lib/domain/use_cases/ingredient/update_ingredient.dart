import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateIngredientUseCase {
  final IngredientRepository repository;

  UpdateIngredientUseCase(this.repository);

  Future<TaskResult<Ingredient>> execute(UpdateIngredientForm form) async {
    return await repository.updateIngredient(form);
  }
}


