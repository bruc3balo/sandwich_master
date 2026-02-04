import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

abstract class SandwichRepository {
  Future<TaskResult<Sandwich>> saveSandwich(SandwichForm form);
  Future<TaskResult<List<Sandwich>>> getAllSandwiches(PageRequest request);
  Future<TaskResult<Sandwich?>> getSandwichById(SandwichId id);
  Future<TaskResult<void>> deleteSandwich(SandwichId id);
}