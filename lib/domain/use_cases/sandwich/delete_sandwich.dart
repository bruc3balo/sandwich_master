import 'package:sandwich_master/domain/repositories/sandwich_repository.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteSandwichUseCase {
  final SandwichRepository repository;

  DeleteSandwichUseCase(this.repository);

  Future<TaskResult<void>> execute(SandwichId id) async {
    return await repository.deleteSandwich(id);
  }
}
