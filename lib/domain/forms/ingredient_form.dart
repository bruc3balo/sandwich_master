import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/value_objects/ingredient_id.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';

class IngredientForm extends Equatable {
  final IngredientId? id;
  final String name;
  final String description;
  final double price;
  final IngredientType type;

  const IngredientForm({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, description, price, type];
}
