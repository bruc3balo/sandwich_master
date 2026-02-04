// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:form_ni_gani/core/di/register_module.dart' as _i493;
import 'package:form_ni_gani/data/data_sources/ingredient/hive_ingredient_data_source.dart'
    as _i1004;
import 'package:form_ni_gani/data/data_sources/ingredient/ingredient_data_source.dart'
    as _i354;
import 'package:form_ni_gani/data/data_sources/sandwich/hive_sandwich_data_source.dart'
    as _i819;
import 'package:form_ni_gani/data/data_sources/sandwich/sandwich_data_source.dart'
    as _i922;
import 'package:form_ni_gani/data/models/ingredient_model.dart' as _i1027;
import 'package:form_ni_gani/data/models/sandwich_model.dart' as _i594;
import 'package:form_ni_gani/data/repositories/ingredient_repository_impl.dart'
    as _i129;
import 'package:form_ni_gani/data/repositories/sandwich_repository_impl.dart'
    as _i747;
import 'package:form_ni_gani/domain/repositories/ingredient_repository.dart'
    as _i1044;
import 'package:form_ni_gani/domain/repositories/sandwich_repository.dart'
    as _i860;
import 'package:form_ni_gani/domain/use_cases/ingredient/add_ingredient.dart'
    as _i56;
import 'package:form_ni_gani/domain/use_cases/ingredient/delete_ingredient.dart'
    as _i133;
import 'package:form_ni_gani/domain/use_cases/ingredient/get_ingredient_by_id.dart'
    as _i760;
import 'package:form_ni_gani/domain/use_cases/ingredient/get_ingredients.dart'
    as _i685;
import 'package:form_ni_gani/domain/use_cases/ingredient/update_ingredient.dart'
    as _i784;
import 'package:form_ni_gani/domain/use_cases/sandwich/delete_sandwich.dart'
    as _i219;
import 'package:form_ni_gani/domain/use_cases/sandwich/get_all_sandwiches.dart'
    as _i83;
import 'package:form_ni_gani/domain/use_cases/sandwich/get_sandwich_by_id.dart'
    as _i955;
import 'package:form_ni_gani/domain/use_cases/sandwich/save_sandwich.dart'
    as _i71;
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_bloc.dart'
    as _i985;
import 'package:form_ni_gani/presentation/features/pantry/pantry_bloc.dart'
    as _i1022;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i986.Box<_i1027.IngredientModel>>(
      () => registerModule.ingredientBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i986.Box<_i594.SandwichModel>>(
      () => registerModule.sandwichBox,
      preResolve: true,
    );
    gh.lazySingleton<_i922.SandwichDataSource>(() =>
        _i819.HiveSandwichDataSource(gh<_i979.Box<_i594.SandwichModel>>()));
    gh.lazySingleton<_i860.SandwichRepository>(
        () => _i747.SandwichRepositoryImpl(gh<_i922.SandwichDataSource>()));
    gh.lazySingleton<_i955.GetSandwichByIdUseCase>(
        () => _i955.GetSandwichByIdUseCase(gh<_i860.SandwichRepository>()));
    gh.lazySingleton<_i71.SaveSandwichUseCase>(
        () => _i71.SaveSandwichUseCase(gh<_i860.SandwichRepository>()));
    gh.lazySingleton<_i219.DeleteSandwichUseCase>(
        () => _i219.DeleteSandwichUseCase(gh<_i860.SandwichRepository>()));
    gh.lazySingleton<_i83.GetAllSandwichesUseCase>(
        () => _i83.GetAllSandwichesUseCase(gh<_i860.SandwichRepository>()));
    gh.lazySingleton<_i354.IngredientDataSource>(() =>
        _i1004.HiveIngredientDataSource(
            gh<_i979.Box<_i1027.IngredientModel>>()));
    gh.factory<_i985.MenuGalleryBloc>(() => _i985.MenuGalleryBloc(
          getAllSandwiches: gh<_i83.GetAllSandwichesUseCase>(),
          deleteSandwich: gh<_i219.DeleteSandwichUseCase>(),
        ));
    gh.lazySingleton<_i1044.IngredientRepository>(
        () => _i129.IngredientRepositoryImpl(gh<_i354.IngredientDataSource>()));
    gh.lazySingleton<_i56.AddIngredientUseCase>(
        () => _i56.AddIngredientUseCase(gh<_i1044.IngredientRepository>()));
    gh.lazySingleton<_i784.UpdateIngredientUseCase>(
        () => _i784.UpdateIngredientUseCase(gh<_i1044.IngredientRepository>()));
    gh.lazySingleton<_i760.GetIngredientByIdUseCase>(() =>
        _i760.GetIngredientByIdUseCase(gh<_i1044.IngredientRepository>()));
    gh.lazySingleton<_i685.GetIngredientsUseCase>(
        () => _i685.GetIngredientsUseCase(gh<_i1044.IngredientRepository>()));
    gh.lazySingleton<_i133.DeleteIngredientUseCase>(
        () => _i133.DeleteIngredientUseCase(gh<_i1044.IngredientRepository>()));
    gh.factory<_i1022.PantryBloc>(() => _i1022.PantryBloc(
          getIngredients: gh<_i685.GetIngredientsUseCase>(),
          deleteIngredient: gh<_i133.DeleteIngredientUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i493.RegisterModule {}
