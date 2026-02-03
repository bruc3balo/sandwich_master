import 'package:equatable/equatable.dart';

class PageRequest extends Equatable {
  final int page;
  final int pageSize;

  const PageRequest({
    required this.page,
    required this.pageSize,
  }) : assert(page >= 0),
       assert(pageSize > 0);

  @override
  List<Object?> get props => [page, pageSize];
}
