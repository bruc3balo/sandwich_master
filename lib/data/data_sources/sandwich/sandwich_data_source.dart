import 'package:sandwich_master/data/models/sandwich_model.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

abstract class SandwichDataSource {
  Future<TaskResult<List<SandwichModel>>> getAll(PageRequest request);
  Future<TaskResult<SandwichModel?>> getById(String id);
  Future<TaskResult<SandwichModel>> save(SandwichModel sandwich);
  Future<TaskResult<void>> delete(String id);
}



