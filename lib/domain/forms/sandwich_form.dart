import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/entities/sandwich.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';

class SandwichForm extends Equatable {
  final SandwichId? id;
  final String name;
  final Bread bread;
  final List<Protein> proteins;
  final List<Topping> toppings;
  final List<Sauce> sauces;
  final Uint8List? image;

  const SandwichForm({
    this.id,
    required this.name,
    required this.bread,
    required this.proteins,
    required this.toppings,
    required this.sauces,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, bread, proteins, toppings, sauces, image];
}
