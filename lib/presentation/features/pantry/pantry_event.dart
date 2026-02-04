import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';
import 'package:sandwich_master/domain/value_objects/ingredient_id.dart';

sealed class PantryEvent extends Equatable {
  const PantryEvent();

  @override
  List<Object?> get props => [];
}

class FetchIngredients extends PantryEvent {
  final bool refresh;
  const FetchIngredients({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class SearchIngredients extends PantryEvent {
  final String query;
  const SearchIngredients(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterByType extends PantryEvent {
  final IngredientType? type;
  const FilterByType(this.type);

  @override
  List<Object?> get props => [type];
}

class DeleteIngredientEvent extends PantryEvent {
  final IngredientId id;
  const DeleteIngredientEvent(this.id);

  @override
  List<Object?> get props => [id];
}
