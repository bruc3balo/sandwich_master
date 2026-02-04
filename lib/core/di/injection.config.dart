// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sandwich_master/core/di/register_module.dart' as _i38;
import 'package:sandwich_master/data/data_sources/ingredient/hive_ingredient_data_source.dart'
    as _i51;
import 'package:sandwich_master/data/data_sources/ingredient/ingredient_data_source.dart'
    as _i306;
import 'package:sandwich_master/data/data_sources/sandwich/hive_sandwich_data_source.dart'
    as _i707;
import 'package:sandwich_master/data/data_sources/sandwich/sandwich_data_source.dart'
    as _i726;
import 'package:sandwich_master/data/models/ingredient_model.dart' as _i260;
import 'package:sandwich_master/data/models/sandwich_model.dart' as _i291;
import 'package:sandwich_master/data/repositories/ingredient_repository_impl.dart'
    as _i526;
import 'package:sandwich_master/data/repositories/sandwich_repository_impl.dart'
    as _i180;
import 'package:sandwich_master/domain/repositories/ingredient_repository.dart'
    as _i492;
import 'package:sandwich_master/domain/repositories/sandwich_repository.dart'
    as _i863;
import 'package:sandwich_master/domain/use_cases/ingredient/add_ingredient.dart'
    as _i578;
import 'package:sandwich_master/domain/use_cases/ingredient/delete_ingredient.dart'
    as _i772;
import 'package:sandwich_master/domain/use_cases/ingredient/get_ingredient_by_id.dart'
    as _i110;
import 'package:sandwich_master/domain/use_cases/ingredient/get_ingredients.dart'
    as _i321;
import 'package:sandwich_master/domain/use_cases/ingredient/update_ingredient.dart'
    as _i899;
import 'package:sandwich_master/domain/use_cases/sandwich/delete_sandwich.dart'
    as _i805;
import 'package:sandwich_master/domain/use_cases/sandwich/get_all_sandwiches.dart'
    as _i1036;
import 'package:sandwich_master/domain/use_cases/sandwich/get_sandwich_by_id.dart'
    as _i230;
import 'package:sandwich_master/domain/use_cases/sandwich/save_sandwich.dart'
    as _i387;
import 'package:sandwich_master/presentation/features/add_ingredient/add_ingredient_bloc.dart'
    as _i335;
import 'package:sandwich_master/presentation/features/menu_gallery/menu_gallery_bloc.dart'
    as _i1024;
import 'package:sandwich_master/presentation/features/pantry/pantry_bloc.dart'
    as _i2;
import 'package:sandwich_master/presentation/features/sandwich_builder/sandwich_builder_bloc.dart'
    as _i935;

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
    await gh.factoryAsync<_i986.Box<_i260.IngredientModel>>(
      () => registerModule.ingredientBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i986.Box<_i291.SandwichModel>>(
      () => registerModule.sandwichBox,
      preResolve: true,
    );
    gh.lazySingleton<_i726.SandwichDataSource>(() =>
        _i707.HiveSandwichDataSource(gh<_i979.Box<_i291.SandwichModel>>()));
    gh.lazySingleton<_i863.SandwichRepository>(
        () => _i180.SandwichRepositoryImpl(gh<_i726.SandwichDataSource>()));
    gh.lazySingleton<_i230.GetSandwichByIdUseCase>(
        () => _i230.GetSandwichByIdUseCase(gh<_i863.SandwichRepository>()));
    gh.lazySingleton<_i387.SaveSandwichUseCase>(
        () => _i387.SaveSandwichUseCase(gh<_i863.SandwichRepository>()));
    gh.lazySingleton<_i805.DeleteSandwichUseCase>(
        () => _i805.DeleteSandwichUseCase(gh<_i863.SandwichRepository>()));
    gh.lazySingleton<_i1036.GetAllSandwichesUseCase>(
        () => _i1036.GetAllSandwichesUseCase(gh<_i863.SandwichRepository>()));
    gh.lazySingleton<_i306.IngredientDataSource>(() =>
        _i51.HiveIngredientDataSource(gh<_i979.Box<_i260.IngredientModel>>()));
    gh.lazySingleton<_i492.IngredientRepository>(
        () => _i526.IngredientRepositoryImpl(gh<_i306.IngredientDataSource>()));
    gh.factory<_i1024.MenuGalleryBloc>(() => _i1024.MenuGalleryBloc(
          getAllSandwiches: gh<_i1036.GetAllSandwichesUseCase>(),
          deleteSandwich: gh<_i805.DeleteSandwichUseCase>(),
        ));
    gh.lazySingleton<_i578.AddIngredientUseCase>(
        () => _i578.AddIngredientUseCase(gh<_i492.IngredientRepository>()));
    gh.lazySingleton<_i899.UpdateIngredientUseCase>(
        () => _i899.UpdateIngredientUseCase(gh<_i492.IngredientRepository>()));
    gh.lazySingleton<_i110.GetIngredientByIdUseCase>(
        () => _i110.GetIngredientByIdUseCase(gh<_i492.IngredientRepository>()));
    gh.lazySingleton<_i321.GetIngredientsUseCase>(
        () => _i321.GetIngredientsUseCase(gh<_i492.IngredientRepository>()));
    gh.lazySingleton<_i772.DeleteIngredientUseCase>(
        () => _i772.DeleteIngredientUseCase(gh<_i492.IngredientRepository>()));
    gh.factory<_i335.AddIngredientBloc>(() => _i335.AddIngredientBloc(
          addIngredient: gh<_i578.AddIngredientUseCase>(),
          updateIngredient: gh<_i899.UpdateIngredientUseCase>(),
        ));
    gh.factory<_i2.PantryBloc>(() => _i2.PantryBloc(
          getIngredients: gh<_i321.GetIngredientsUseCase>(),
          deleteIngredient: gh<_i772.DeleteIngredientUseCase>(),
        ));
    gh.factory<_i935.SandwichBuilderBloc>(() => _i935.SandwichBuilderBloc(
          getIngredients: gh<_i321.GetIngredientsUseCase>(),
          saveSandwich: gh<_i387.SaveSandwichUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i38.RegisterModule {}
