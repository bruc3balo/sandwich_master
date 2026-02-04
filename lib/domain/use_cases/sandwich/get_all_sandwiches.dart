import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/repositories/sandwich_repository.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllSandwichesUseCase {
  final SandwichRepository repository;

  GetAllSandwichesUseCase(this.repository);

  Future<TaskResult<List<Sandwich>>> execute(PageRequest request) async {
    return await repository.getAllSandwiches(request);
  }
}
