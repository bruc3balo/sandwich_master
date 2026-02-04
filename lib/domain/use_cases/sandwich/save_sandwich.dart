import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/forms/sandwich_form.dart';
import 'package:form_ni_gani/domain/repositories/sandwich_repository.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class SaveSandwichUseCase {
  final SandwichRepository repository;

  SaveSandwichUseCase(this.repository);

  Future<TaskResult<Sandwich>> execute(SandwichForm form) async {
    return await repository.saveSandwich(form);
  }
}

