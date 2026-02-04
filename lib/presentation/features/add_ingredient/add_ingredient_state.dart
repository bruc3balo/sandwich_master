import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';

sealed class AddIngredientState extends Equatable {
  const AddIngredientState();

  @override
  List<Object?> get props => [];
}

class AddIngredientInitial extends AddIngredientState {
  final Ingredient? originalIngredient;
  final String name;
  final String description;
  final double price;
  final IngredientType type;
  final Uint8List? image;
  final bool isSubmitting;

  const AddIngredientInitial({
    this.originalIngredient,
    this.name = '',
    this.description = '',
    this.price = 0.0,
    this.type = IngredientType.bread,
    this.image,
    this.isSubmitting = false,
  });

  bool get isEdit => originalIngredient != null;
  bool get isValid => name.isNotEmpty && price > 0;

  @override
  List<Object?> get props => [originalIngredient, name, description, price, type, image, isSubmitting];

  AddIngredientInitial copyWith({
    Ingredient? originalIngredient,
    String? name,
    String? description,
    double? price,
    IngredientType? type,
    Uint8List? image,
    bool? isSubmitting,
  }) {
    return AddIngredientInitial(
      originalIngredient: originalIngredient ?? this.originalIngredient,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      image: image ?? this.image,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class AddIngredientSuccess extends AddIngredientState {}

class AddIngredientError extends AddIngredientState {
  final String message;
  const AddIngredientError(this.message);

  @override
  List<Object?> get props => [message];
}
