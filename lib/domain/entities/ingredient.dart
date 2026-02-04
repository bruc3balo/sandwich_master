import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';
import 'package:form_ni_gani/domain/forms/ingredient_form.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';

abstract class Ingredient extends Equatable {
  final IngredientId id;
  final String name;
  final String description;
  final double price;
  final IngredientType type;

  const Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
  });

  factory Ingredient.fromCreateForm(IngredientId id, CreateIngredientForm form) {
    switch (form.type) {
      case IngredientType.bread:
        return Bread(
          id: id,
          name: form.name,
          description: form.description,
          price: form.price,
        );
      case IngredientType.protein:
        return Protein(
          id: id,
          name: form.name,
          description: form.description,
          price: form.price,
        );
      case IngredientType.topping:
        return Topping(
          id: id,
          name: form.name,
          description: form.description,
          price: form.price,
        );
      case IngredientType.sauce:
        return Sauce(
          id: id,
          name: form.name,
          description: form.description,
          price: form.price,
        );
    }
  }

  factory Ingredient.fromUpdateForm(UpdateIngredientForm form, Ingredient existing) {
    final name = form.name ?? existing.name;
    final description = form.description ?? existing.description;
    final price = form.price ?? existing.price;
    final type = form.type ?? existing.type;

    switch (type) {
      case IngredientType.bread:
        return Bread(
          id: form.id,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.protein:
        return Protein(
          id: form.id,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.topping:
        return Topping(
          id: form.id,
          name: name,
          description: description,
          price: price,
        );
      case IngredientType.sauce:
        return Sauce(
          id: form.id,
          name: name,
          description: description,
          price: price,
        );
    }
  }

  @override
  List<Object?> get props => [id, name, description, price, type];
}

