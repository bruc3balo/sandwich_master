import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';

sealed class SandwichBuilderState extends Equatable {
  const SandwichBuilderState();

  @override
  List<Object?> get props => [];
}

class SandwichBuilderInitial extends SandwichBuilderState {}

class SandwichBuilderLoading extends SandwichBuilderState {}

class SandwichBuilderReady extends SandwichBuilderState {
  final List<Ingredient> availableIngredients;
  final String name;
  final Bread? bread;
  final List<Protein> proteins;
  final List<Topping> toppings;
  final List<Sauce> sauces;
  final bool isSaving;

  const SandwichBuilderReady({
    required this.availableIngredients,
    this.name = '',
    this.bread,
    this.proteins = const [],
    this.toppings = const [],
    this.sauces = const [],
    this.isSaving = false,
  });

  bool get isValid => name.isNotEmpty && bread != null && (proteins.isNotEmpty || toppings.isNotEmpty);

  double get totalPrice {
    double total = (bread?.price ?? 0.0);
    total += proteins.fold(0.0, (sum, item) => sum + item.price);
    total += toppings.fold(0.0, (sum, item) => sum + item.price);
    total += sauces.fold(0.0, (sum, item) => sum + item.price);
    return total;
  }

  @override
  List<Object?> get props => [availableIngredients, name, bread, proteins, toppings, sauces, isSaving];

  SandwichBuilderReady copyWith({
    List<Ingredient>? availableIngredients,
    String? name,
    Bread? bread,
    List<Protein>? proteins,
    List<Topping>? toppings,
    List<Sauce>? sauces,
    bool? isSaving,
  }) {
    return SandwichBuilderReady(
      availableIngredients: availableIngredients ?? this.availableIngredients,
      name: name ?? this.name,
      bread: bread ?? this.bread,
      proteins: proteins ?? this.proteins,
      toppings: toppings ?? this.toppings,
      sauces: sauces ?? this.sauces,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class SandwichBuilderSuccess extends SandwichBuilderState {}

class SandwichBuilderError extends SandwichBuilderState {
  final String message;
  const SandwichBuilderError(this.message);

  @override
  List<Object?> get props => [message];
}
