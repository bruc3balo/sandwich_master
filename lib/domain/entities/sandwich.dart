import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/value_objects/sandwich_id.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';

class Sandwich extends Equatable {
  final SandwichId id;
  final String name;
  final Bread bread;
  final List<Protein> proteins;
  final List<Topping> toppings;
  final List<Sauce> sauces;

  const Sandwich({
    required this.id,
    required this.name,
    required this.bread,
    required this.proteins,
    required this.toppings,
    required this.sauces,
  });

  double get totalPrice {
    double total = bread.price;
    total += proteins.fold(0, (sum, p) => sum + p.price);
    total += toppings.fold(0, (sum, t) => sum + t.price);
    total += sauces.fold(0, (sum, s) => sum + s.price);
    return total;
  }

  @override
  List<Object?> get props => [id, name, bread, proteins, toppings, sauces];
}
