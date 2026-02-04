import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/repositories/ingredient_repository.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetIngredientsUseCase {
  final IngredientRepository repository;

  GetIngredientsUseCase(this.repository);

  Future<TaskResult<List<Ingredient>>> execute(PageRequest request) async {
    return await repository.getIngredients(request);
  }
}
