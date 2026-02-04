import 'package:form_ni_gani/data/models/sandwich_model.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

abstract class SandwichDataSource {
  Future<TaskResult<List<SandwichModel>>> getAll(PageRequest request);
  Future<TaskResult<SandwichModel?>> getById(String id);
  Future<TaskResult<SandwichModel>> save(SandwichModel sandwich);
  Future<TaskResult<void>> delete(String id);
}



