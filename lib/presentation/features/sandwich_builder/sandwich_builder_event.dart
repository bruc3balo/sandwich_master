import 'package:equatable/equatable.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';

sealed class SandwichBuilderEvent extends Equatable {
  const SandwichBuilderEvent();

  @override
  List<Object?> get props => [];
}

class LoadIngredients extends SandwichBuilderEvent {}

class UpdateName extends SandwichBuilderEvent {
  final String name;
  const UpdateName(this.name);

  @override
  List<Object?> get props => [name];
}

class SelectBread extends SandwichBuilderEvent {
  final Bread bread;
  const SelectBread(this.bread);

  @override
  List<Object?> get props => [bread];
}

class ToggleProtein extends SandwichBuilderEvent {
  final Protein protein;
  const ToggleProtein(this.protein);

  @override
  List<Object?> get props => [protein];
}

class ToggleTopping extends SandwichBuilderEvent {
  final Topping topping;
  const ToggleTopping(this.topping);

  @override
  List<Object?> get props => [topping];
}

class ToggleSauce extends SandwichBuilderEvent {
  final Sauce sauce;
  const ToggleSauce(this.sauce);

  @override
  List<Object?> get props => [sauce];
}

class SaveSandwichEvent extends SandwichBuilderEvent {}
