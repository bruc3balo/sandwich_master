import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_ni_gani/domain/use_cases/sandwich/get_all_sandwiches.dart';
import 'package:form_ni_gani/domain/use_cases/sandwich/delete_sandwich.dart';
import 'package:form_ni_gani/domain/value_objects/page_request.dart';
import 'package:form_ni_gani/domain/utils/task_result.dart';
import 'menu_gallery_event.dart';
import 'menu_gallery_state.dart';

@injectable
class MenuGalleryBloc extends Bloc<MenuGalleryEvent, MenuGalleryState> {
  final GetAllSandwichesUseCase _getAllSandwiches;
  final DeleteSandwichUseCase _deleteSandwich;

  MenuGalleryBloc({
    required GetAllSandwichesUseCase getAllSandwiches,
    required DeleteSandwichUseCase deleteSandwich,
  })  : _getAllSandwiches = getAllSandwiches,
        _deleteSandwich = deleteSandwich,
        super(MenuGalleryInitial()) {
    on<FetchSandwiches>(_onFetchSandwiches);
    on<DeleteSandwichEvent>(_onDeleteSandwich);
  }

  Future<void> _onFetchSandwiches(
    FetchSandwiches event,
    Emitter<MenuGalleryState> emit,
  ) async {
    if (state is! MenuGalleryLoaded || event.refresh) {
      emit(MenuGalleryLoading());
    }

    final result = await _getAllSandwiches.execute(
      const PageRequest(offset: 0, limit: 100), // Standard limit for gallery
    );

    switch (result) {
      case Success(data: final sandwiches):
        emit(MenuGalleryLoaded(sandwiches));
      case Failure(message: final msg):
        emit(MenuGalleryError(msg));
    }
  }

  Future<void> _onDeleteSandwich(
    DeleteSandwichEvent event,
    Emitter<MenuGalleryState> emit,
  ) async {
    final result = await _deleteSandwich.execute(event.id);

    switch (result) {
      case Success():
        // Refetch after successful deletion
        add(const FetchSandwiches(refresh: false));
      case Failure(message: final msg):
        // We could emit a temporary error state or keep the current state and show a snackbar
        // For simplicity in this implementation, we'll emit the error state
        emit(MenuGalleryError('Failed to delete sandwich: $msg'));
    }
  }
}
