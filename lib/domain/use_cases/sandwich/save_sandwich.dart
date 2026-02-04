import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'package:sandwich_master/domain/repositories/sandwich_repository.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class SaveSandwichUseCase {
  final SandwichRepository repository;

  SaveSandwichUseCase(this.repository);

  Future<TaskResult<Sandwich>> execute(SandwichForm form) async {
    return await repository.saveSandwich(form);
  }
}

