import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';

abstract class SandwichDataSource {
  Future<List<Sandwich>> getAll(PageRequest request);
  Future<Sandwich?> getById(SandwichId id);
  Future<void> save(Sandwich sandwich);
  Future<void> delete(SandwichId id);
}
