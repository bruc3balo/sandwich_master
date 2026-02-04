import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandwich_master/domain/use_cases/ingredient/add_ingredient.dart';
import 'package:sandwich_master/domain/use_cases/ingredient/update_ingredient.dart';
import 'package:sandwich_master/domain/forms/ingredient_form.dart';
import 'package:sandwich_master/domain/utils/task_result.dart';
import 'add_ingredient_event.dart';
import 'add_ingredient_state.dart';

@injectable
class AddIngredientBloc extends Bloc<AddIngredientEvent, AddIngredientState> {
  final AddIngredientUseCase _addIngredient;
  final UpdateIngredientUseCase _updateIngredient;

  AddIngredientBloc({
    required AddIngredientUseCase addIngredient,
    required UpdateIngredientUseCase updateIngredient,
  })  : _addIngredient = addIngredient,
        _updateIngredient = updateIngredient,
        super(const AddIngredientInitial()) {
    on<InitializeForUpdate>(_onInitializeForUpdate);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<PriceChanged>(_onPriceChanged);
    on<TypeChanged>(_onTypeChanged);
    on<ImageChanged>(_onImageChanged);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onInitializeForUpdate(InitializeForUpdate event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      final i = event.ingredient;
      emit((state as AddIngredientInitial).copyWith(
        originalIngredient: i,
        name: i.name,
        description: i.description,
        price: i.price,
        type: i.type,
        image: i.image,
      ));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      emit((state as AddIngredientInitial).copyWith(name: event.name));
    }
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      emit((state as AddIngredientInitial).copyWith(description: event.description));
    }
  }

  void _onPriceChanged(PriceChanged event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      emit((state as AddIngredientInitial).copyWith(price: event.price));
    }
  }

  void _onTypeChanged(TypeChanged event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      emit((state as AddIngredientInitial).copyWith(type: event.type));
    }
  }

  void _onImageChanged(ImageChanged event, Emitter<AddIngredientState> emit) {
    if (state is AddIngredientInitial) {
      emit((state as AddIngredientInitial).copyWith(image: event.image));
    }
  }

  Future<void> _onSubmitForm(SubmitForm event, Emitter<AddIngredientState> emit) async {
    final s = state;
    if (s is AddIngredientInitial && s.isValid) {
      emit(s.copyWith(isSubmitting: true));

      final result = s.isEdit 
        ? await _updateIngredient.execute(UpdateIngredientForm(
            id: s.originalIngredient!.id,
            name: s.name,
            description: s.description,
            price: s.price,
            type: s.type,
            image: s.image,
          ))
        : await _addIngredient.execute(CreateIngredientForm(
            name: s.name,
            description: s.description,
            price: s.price,
            type: s.type,
            image: s.image,
          ));

      switch (result) {
        case Success():
          emit(AddIngredientSuccess());
        case Failure(message: final msg):
          emit(s.copyWith(isSubmitting: false));
          emit(AddIngredientError(msg));
      }
    }
  }
}
