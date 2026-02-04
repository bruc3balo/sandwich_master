import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:sandwich_master/data/data_sources/sandwich/sandwich_data_source.dart';
import 'package:sandwich_master/data/models/sandwich_model.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';

@LazySingleton(as: SandwichDataSource)
class HiveSandwichDataSource implements SandwichDataSource {
  final Box<SandwichModel> _box;

  HiveSandwichDataSource(this._box);

  @override
  Future<TaskResult<List<SandwichModel>>> getAll(PageRequest request) async {
    try {
      final keys = _box.keys;
      
      final paginatedKeys = keys.skip(request.offset).take(request.limit);
      
      final models = paginatedKeys
          .map((key) => _box.get(key))
          .whereType<SandwichModel>()
          .toList();

      return Success(data: models);
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


