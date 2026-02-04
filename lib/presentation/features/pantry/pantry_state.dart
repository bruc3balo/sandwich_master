import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';

sealed class PantryState extends Equatable {
  const PantryState();

  @override
  List<Object?> get props => [];
}

class PantryInitial extends PantryState {}

class PantryLoading extends PantryState {}

class PantryLoaded extends PantryState {
  final List<Ingredient> allIngredients;
  final List<Ingredient> filteredIngredients;
  final String searchQuery;
  final IngredientType? selectedType;

  const PantryLoaded({
    required this.allIngredients,
    required this.filteredIngredients,
    this.searchQuery = '',
    this.selectedType,
  });

  @override
  List<Object?> get props => [allIngredients, filteredIngredients, searchQuery, selectedType];

  PantryLoaded copyWith({
    List<Ingredient>? allIngredients,
    List<Ingredient>? filteredIngredients,
    String? searchQuery,
    IngredientType? selectedType,
  }) {
    return PantryLoaded(
      allIngredients: allIngredients ?? this.allIngredients,
      filteredIngredients: filteredIngredients ?? this.filteredIngredients,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}

class PantryError extends PantryState {
  final String message;
  const PantryError(this.message);

  @override
  List<Object?> get props => [message];
}
