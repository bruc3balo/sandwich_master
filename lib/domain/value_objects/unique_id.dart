import 'package:equatable/equatable.dart';

abstract class UniqueId extends Equatable {
  final String value;

  const UniqueId(this.value);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
