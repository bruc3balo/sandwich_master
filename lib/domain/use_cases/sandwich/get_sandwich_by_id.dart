import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/repositories/sandwich_repository.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class GetSandwichById {
  final SandwichRepository repository;

  GetSandwichById(this.repository);

  Future<TaskResult<Sandwich?>> execute(SandwichId id) async {
    return await repository.getSandwichById(id);
  }
}
