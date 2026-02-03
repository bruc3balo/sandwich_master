import 'package:form_ni_gani/domain/repositories/sandwich_repository.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class DeleteSandwich {
  final SandwichRepository repository;

  DeleteSandwich(this.repository);

  Future<TaskResult<void>> execute(SandwichId id) async {
    return await repository.deleteSandwich(id);
  }
}
