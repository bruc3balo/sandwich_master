import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';

sealed class AddIngredientEvent extends Equatable {
  const AddIngredientEvent();

  @override
  List<Object?> get props => [];
}

class InitializeForUpdate extends AddIngredientEvent {
  final Ingredient ingredient;
  const InitializeForUpdate(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class NameChanged extends AddIngredientEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class DescriptionChanged extends AddIngredientEvent {
  final String description;
  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class PriceChanged extends AddIngredientEvent {
  final double price;
  const PriceChanged(this.price);

  @override
  List<Object?> get props => [price];
}

class TypeChanged extends AddIngredientEvent {
  final IngredientType type;
  const TypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}

class ImageChanged extends AddIngredientEvent {
  final Uint8List? image;
  const ImageChanged(this.image);

  @override
  List<Object?> get props => [image];
}

class SubmitForm extends AddIngredientEvent {}
