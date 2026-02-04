import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:form_ni_gani/domain/use_cases/ingredient/get_ingredients.dart';
import 'package:form_ni_gani/domain/use_cases/ingredient/delete_ingredient.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'pantry_event.dart';
import 'pantry_state.dart';

@injectable
class PantryBloc extends Bloc<PantryEvent, PantryState> {
  final GetIngredientsUseCase _getIngredients;
  final DeleteIngredientUseCase _deleteIngredient;

  PantryBloc({
    required GetIngredientsUseCase getIngredients,
    required DeleteIngredientUseCase deleteIngredient,
  })  : _getIngredients = getIngredients,
        _deleteIngredient = deleteIngredient,
        super(PantryInitial()) {
    on<FetchIngredients>(_onFetchIngredients);
    on<SearchIngredients>(_onSearchIngredients);
    on<FilterByType>(_onFilterByType);
    on<DeleteIngredientEvent>(_onDeleteIngredient);
  }

  Future<void> _onFetchIngredients(
    FetchIngredients event,
    Emitter<PantryState> emit,
  ) async {
    if (state is! PantryLoaded || event.refresh) {
      emit(PantryLoading());
    }

    final result = await _getIngredients.execute(
      const PageRequest(page: 0, pageSize: 200), // Load a batch for pantry
    );

    switch (result) {
      case Success(data: final ingredients):
        emit(PantryLoaded(
          allIngredients: ingredients,
          filteredIngredients: ingredients,
        ));
      case Failure(message: final msg):
        emit(PantryError(msg));
    }
  }

  void _onSearchIngredients(
    SearchIngredients event,
    Emitter<PantryState> emit,
  ) {
    final currentState = state;
    if (currentState is PantryLoaded) {
      final filtered = _applyFilters(
        currentState.allIngredients,
        event.query,
        currentState.selectedType,
      );
      emit(currentState.copyWith(
        filteredIngredients: filtered,
        searchQuery: event.query,
      ));
    }
  }

  void _onFilterByType(
    FilterByType event,
    Emitter<PantryState> emit,
  ) {
    final currentState = state;
    if (currentState is PantryLoaded) {
      final filtered = _applyFilters(
        currentState.allIngredients,
        currentState.searchQuery,
        event.type,
      );
      emit(currentState.copyWith(
        filteredIngredients: filtered,
        selectedType: event.type,
      ));
    }
  }

  Future<void> _onDeleteIngredient(
    DeleteIngredientEvent event,
    Emitter<PantryState> emit,
  ) async {
    final result = await _deleteIngredient.execute(event.id);

    switch (result) {
      case Success():
        add(const FetchIngredients(refresh: false));
      case Failure(message: final msg):
        // Potential logic for temporary error state or snackbar
        emit(PantryError('Failed to delete: $msg'));
    }
  }

  List<Ingredient> _applyFilters(
    List<Ingredient> ingredients,
    String query,
    dynamic type,
  ) {
    return ingredients.where((i) {
      final matchesQuery = i.name.toLowerCase().contains(query.toLowerCase());
      final matchesType = type == null || i.type == type;
      return matchesQuery && matchesType;
    }).toList();
  }
}
