import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandwich_master/domain/use_cases/ingredient/get_ingredients.dart';
import 'package:sandwich_master/domain/use_cases/sandwich/save_sandwich.dart';
import 'package:sandwich_master/domain/value_objects/page_request.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';
import 'package:sandwich_master/domain/entities/bread.dart';
import 'package:sandwich_master/domain/entities/protein.dart';
import 'package:sandwich_master/domain/entities/topping.dart';
import 'package:sandwich_master/domain/entities/sauce.dart';
import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'sandwich_builder_event.dart';
import 'sandwich_builder_state.dart';

@injectable
class SandwichBuilderBloc extends Bloc<SandwichBuilderEvent, SandwichBuilderState> {
  final GetIngredientsUseCase _getIngredients;
  final SaveSandwichUseCase _saveSandwich;

  SandwichBuilderBloc({
    required GetIngredientsUseCase getIngredients,
    required SaveSandwichUseCase saveSandwich,
  })  : _getIngredients = getIngredients,
        _saveSandwich = saveSandwich,
        super(SandwichBuilderInitial()) {
    on<LoadIngredients>(_onLoadIngredients);
    on<InitializeForEdit>(_onInitializeForEdit);
    on<UpdateName>(_onUpdateName);
    on<SelectBread>(_onSelectBread);
    on<ToggleProtein>(_onToggleProtein);
    on<ToggleTopping>(_onToggleTopping);
    on<ToggleSauce>(_onToggleSauce);
    on<ImageChanged>(_onImageChanged);
    on<SaveSandwichEvent>(_onSaveSandwich);
  }

  void _onInitializeForEdit(InitializeForEdit event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      final s = state as SandwichBuilderReady;
      emit(s.copyWith(
        id: event.sandwich.id,
        name: event.sandwich.name,
        bread: event.sandwich.bread,
        proteins: event.sandwich.proteins,
        toppings: event.sandwich.toppings,
        sauces: event.sandwich.sauces,
        image: event.sandwich.image,
      ));
    }
  }

  Future<void> _onLoadIngredients(
    LoadIngredients event,
    Emitter<SandwichBuilderState> emit,
  ) async {
    emit(SandwichBuilderLoading());
    final result = await _getIngredients.execute(const PageRequest(page: 0, pageSize: 100));

    switch (result) {
      case Success(data: final ingredients):
        if (state is SandwichBuilderReady) {
          emit((state as SandwichBuilderReady).copyWith(availableIngredients: ingredients));
        } else {
          emit(SandwichBuilderReady(availableIngredients: ingredients));
        }
      case Failure(message: final msg):
        emit(SandwichBuilderError(msg));
    }
  }

  void _onUpdateName(UpdateName event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      emit((state as SandwichBuilderReady).copyWith(name: event.name));
    }
  }

  void _onSelectBread(SelectBread event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      emit((state as SandwichBuilderReady).copyWith(bread: event.bread));
    }
  }

  void _onToggleProtein(ToggleProtein event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      final s = state as SandwichBuilderReady;
      final list = List<Protein>.from(s.proteins);
      if (list.contains(event.protein)) {
        list.remove(event.protein);
      } else {
        list.add(event.protein);
      }
      emit(s.copyWith(proteins: list));
    }
  }

  void _onToggleTopping(ToggleTopping event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      final s = state as SandwichBuilderReady;
      final list = List<Topping>.from(s.toppings);
      if (list.contains(event.topping)) {
        list.remove(event.topping);
      } else {
        list.add(event.topping);
      }
      emit(s.copyWith(toppings: list));
    }
  }

  void _onToggleSauce(ToggleSauce event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      final s = state as SandwichBuilderReady;
      final list = List<Sauce>.from(s.sauces);
      if (list.contains(event.sauce)) {
        list.remove(event.sauce);
      } else {
        list.add(event.sauce);
      }
      emit(s.copyWith(sauces: list));
    }
  }

  void _onImageChanged(ImageChanged event, Emitter<SandwichBuilderState> emit) {
    if (state is SandwichBuilderReady) {
      emit((state as SandwichBuilderReady).copyWith(image: event.image));
    }
  }

  Future<void> _onSaveSandwich(
    SaveSandwichEvent event,
    Emitter<SandwichBuilderState> emit,
  ) async {
    final s = state;
    if (s is SandwichBuilderReady && s.isValid) {
      emit(s.copyWith(isSaving: true));
      
      final form = SandwichForm(
        id: s.id,
        name: s.name,
        bread: s.bread!,
        proteins: s.proteins,
        toppings: s.toppings,
        sauces: s.sauces,
        image: s.image,
      );

      final result = await _saveSandwich.execute(form);
      
      switch (result) {
        case Success():
          emit(SandwichBuilderSuccess());
        case Failure(message: final msg):
          emit(s.copyWith(isSaving: false));
          // We could emit a temporary error or keep the state
          emit(SandwichBuilderError('Failed to save: $msg'));
      }
    }
  }
}
