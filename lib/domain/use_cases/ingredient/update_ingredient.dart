import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/forms/ingredient_form.dart';
import 'package:sandwich_master/domain/repositories/ingredient_repository.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateIngredientUseCase {
  final IngredientRepository repository;

  UpdateIngredientUseCase(this.repository);

  Future<TaskResult<Ingredient>> execute(UpdateIngredientForm form) async {
    return await repository.updateIngredient(form);
  }
}


