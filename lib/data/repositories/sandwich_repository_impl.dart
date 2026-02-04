import 'package:injectable/injectable.dart';
import 'package:sandwich_master/data/data_sources/sandwich/sandwich_data_source.dart';
import 'package:sandwich_master/data/models/sandwich_model.dart';
import 'package:sandwich_master/data/mappers/entity_to_local.dart';
import 'package:sandwich_master/data/mappers/local_to_entity.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'package:sandwich_master/domain/repositories/sandwich_repository.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';

@LazySingleton(as: SandwichRepository)
class SandwichRepositoryImpl implements SandwichRepository {
  final SandwichDataSource _dataSource;

  SandwichRepositoryImpl(this._dataSource);

  @override
  Future<TaskResult<Sandwich>> saveSandwich(SandwichForm form) async {
    try {
      final sandwichEntity = Sandwich.fromForm(form);
      
      final result = await _dataSource.save(sandwichEntity.toLocal);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final savedModel):
          final sandwich = savedModel.toEntity;
          return Success(data: sandwich);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error saving sandwich: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<List<Sandwich>>> getAllSandwiches(PageRequest request) async {
    try {
      final result = await _dataSource.getAll(request);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final models):
          final sandwiches = models.map((m) => m.toEntity).toList();
          return Success(data: sandwiches);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error fetching sandwiches: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<Sandwich?>> getSandwichById(SandwichId id) async {
    try {
      final result = await _dataSource.getById(id.value);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success(data: final model):
          final sandwich = model?.toEntity;
          return Success(data: sandwich);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error fetching sandwich by id: $e', trace: stackTrace);
    }
  }

  @override
  Future<TaskResult<void>> deleteSandwich(SandwichId id) async {
    try {
      final result = await _dataSource.delete(id.value);
      switch (result) {
        case Failure(message: final msg, trace: final trace):
          return Failure(message: msg, trace: trace);
        case Success():
          return const Success(data: null);
      }
    } catch (e, stackTrace) {
      return Failure(message: 'Repository error deleting sandwich: $e', trace: stackTrace);
    }
  }

}


