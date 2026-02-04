import 'package:hive/hive.dart';
import 'package:form_ni_gani/data/data_sources/sandwich/sandwich_data_source.dart';
import 'package:form_ni_gani/data/models/sandwich_model.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';

class HiveSandwichDataSource implements SandwichDataSource {
  final Box<SandwichModel> _box;

  HiveSandwichDataSource(this._box);

  @override
  Future<TaskResult<List<SandwichModel>>> getAll(PageRequest request) async {
    try {
      final models = _box.values.toList();

      // Sort by name by default
      models.sort((a, b) => a.name.compareTo(b.name));

      final start = request.offset;
      final end = (request.offset + request.limit).clamp(0, models.length);

      if (start >= models.length) {
        return const Success(data: [], message: 'No sandwiches found for this page');
      }

      final paginatedModels = models.sublist(start, end);

      return Success(data: paginatedModels);
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to fetch sandwiches: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<SandwichModel?>> getById(String id) async {
    try {
      final model = _box.get(id);
      return Success(data: model);
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to fetch sandwich by id: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<SandwichModel>> save(SandwichModel sandwich) async {
    try {
      await _box.put(sandwich.id, sandwich);
      return Success(data: sandwich, message: 'Sandwich saved successfully');
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to save sandwich: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<void>> delete(String id) async {
    try {
      if (!_box.containsKey(id)) {
        return const Failure(message: 'Sandwich not found');
      }
      await _box.delete(id);
      return const Success(data: null, message: 'Sandwich deleted successfully');
    } catch (e, stackTrace) {
      return Failure(message: 'Failed to delete sandwich: $e', trace: stackTrace);
    }
  }
}


