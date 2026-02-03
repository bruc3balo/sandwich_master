import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';

abstract class Ingredient extends Equatable {
  final IngredientId id;
  final String name;
  final String description;
  final double price;

  const Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, description, price];
}
