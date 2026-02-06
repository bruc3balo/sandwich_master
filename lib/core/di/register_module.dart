import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:sandwich_master/data/models/ingredient_model.dart';
import 'package:sandwich_master/data/models/sandwich_model.dart';
import 'package:sandwich_master/data/models/ingredient_type_model.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<Box<IngredientModel>> get ingredientBox => _openBox<IngredientModel>('ingredients');

  @preResolve
  Future<Box<SandwichModel>> get sandwichBox => _openBox<SandwichModel>('sandwiches');

  @preResolve
  Future<Box> get settingsBox => _openBox<dynamic>('settings');

  Future<Box<T>> _openBox<T>(String name) async {
    _registerAdapters();
    return await Hive.openBox<T>(name);
  }

  void _registerAdapters() {
    if (Hive.isAdapterRegistered(0)) return;

    Hive
      ..registerAdapter(IngredientModelAdapter())     // Index 0
      ..registerAdapter(SandwichModelAdapter())       // Index 1
      ..registerAdapter(IngredientTypeModelAdapter()); // Index 2
  }
}
