import 'package:form_ni_gani/domain/forms/sandwich_form.dart';
import 'package:form_ni_gani/domain/repositories/sandwich_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class SaveSandwich {
  final SandwichRepository repository;

  SaveSandwich(this.repository);

  Future<TaskResult<void>> execute(SandwichForm form) async {
    return await repository.saveSandwich(form);
  }
}
