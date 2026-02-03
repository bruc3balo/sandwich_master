import 'package:form_ni_gani/domain/forms/sandwich_form.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

abstract class SandwichRepository {
  Future<TaskResult<void>> saveSandwich(SandwichForm form);
  Future<TaskResult<List<Sandwich>>> getAllSandwiches(PageRequest request);
  Future<TaskResult<Sandwich?>> getSandwichById(SandwichId id);
  Future<TaskResult<void>> deleteSandwich(SandwichId id);
}