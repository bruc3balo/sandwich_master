import 'package:equatable/equatable.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';

abstract class MenuGalleryState extends Equatable {
  const MenuGalleryState();

  @override
  List<Object?> get props => [];
}

class MenuGalleryInitial extends MenuGalleryState {}

class MenuGalleryLoading extends MenuGalleryState {}

class MenuGalleryLoaded extends MenuGalleryState {
  final List<Sandwich> sandwiches;

  const MenuGalleryLoaded(this.sandwiches);

  @override
  List<Object?> get props => [sandwiches];
}

class MenuGalleryError extends MenuGalleryState {
  final String message;

  const MenuGalleryError(this.message);

  @override
  List<Object?> get props => [message];
}
