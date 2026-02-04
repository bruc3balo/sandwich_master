import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/entities/bread.dart';
import 'package:sandwich_master/domain/entities/protein.dart';
import 'package:sandwich_master/domain/entities/sauce.dart';
import 'package:sandwich_master/domain/entities/topping.dart';
import 'package:sandwich_master/domain/forms/sandwich_form.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';

class Sandwich extends Equatable {
  final SandwichId id;
  final String name;
  final Bread bread;
  final List<Protein> proteins;
  final List<Topping> toppings;
  final List<Sauce> sauces;
  final Uint8List? image;

  const Sandwich({
    required this.id,
    required this.name,
    required this.bread,
    required this.proteins,
    required this.toppings,
    required this.sauces,
    this.image,
  });

  factory Sandwich.fromForm(SandwichForm form) {
    final id = form.id ?? SandwichId(DateTime.now().microsecondsSinceEpoch.toString());
    
    return Sandwich(
      id: id,
      name: form.name,
      bread: form.bread,
      proteins: form.proteins,
      toppings: form.toppings,
      sauces: form.sauces,
      image: form.image,
    );
  }

  double get totalPrice {
    double total = bread.price;
    total += proteins.fold(0, (sum, p) => sum + p.price);
    total += toppings.fold(0, (sum, t) => sum + t.price);
    total += sauces.fold(0, (sum, s) => sum + s.price);
    return total;
  }

  @override
  List<Object?> get props => [id, name, bread, proteins, toppings, sauces, image];
}

