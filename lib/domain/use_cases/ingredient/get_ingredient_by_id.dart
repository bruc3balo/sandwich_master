import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetIngredientByIdUseCase {
  final IngredientRepository repository;

  GetIngredientByIdUseCase(this.repository);

  Future<TaskResult<Ingredient?>> execute(IngredientId id) async {
    return await repository.getIngredientById(id);
  }
}
