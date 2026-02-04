import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/repositories/sandwich_repository.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetSandwichByIdUseCase {
  final SandwichRepository repository;

  GetSandwichByIdUseCase(this.repository);

  Future<TaskResult<Sandwich?>> execute(SandwichId id) async {
    return await repository.getSandwichById(id);
  }
}
