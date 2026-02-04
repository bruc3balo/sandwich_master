import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/value_objects/sandwich_id.dart';

abstract class MenuGalleryEvent extends Equatable {
  const MenuGalleryEvent();

  @override
  List<Object?> get props => [];
}

class FetchSandwiches extends MenuGalleryEvent {
  final bool refresh;

  const FetchSandwiches({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class DeleteSandwichEvent extends MenuGalleryEvent {
  final SandwichId id;

  const DeleteSandwichEvent(this.id);

  @override
  List<Object?> get props => [id];
}
