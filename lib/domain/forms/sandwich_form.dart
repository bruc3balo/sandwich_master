import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/entities/bread.dart';
import 'package:sandwich_master/domain/entities/protein.dart';
import 'package:sandwich_master/domain/entities/topping.dart';
import 'package:sandwich_master/domain/entities/sauce.dart';

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
