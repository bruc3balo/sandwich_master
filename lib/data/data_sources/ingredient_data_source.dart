import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';

abstract class IngredientDataSource {
  Future<List<Ingredient>> getAll(PageRequest request);
  Future<Ingredient?> getById(IngredientId id);
  Future<void> create(Ingredient ingredient);
  Future<void> update(Ingredient ingredient);
  Future<void> delete(IngredientId id);
}
