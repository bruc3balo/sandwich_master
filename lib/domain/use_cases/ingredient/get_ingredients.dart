import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class GetIngredients {
  final IngredientRepository repository;

  GetIngredients(this.repository);

  Future<TaskResult<List<Ingredient>>> execute(PageRequest request) async {
    return await repository.getIngredients(request);
  }
}
