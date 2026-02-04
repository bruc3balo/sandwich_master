import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';
import 'add_ingredient_bloc.dart';
import 'add_ingredient_event.dart';
import 'add_ingredient_state.dart';

class AddIngredientScreen extends StatelessWidget {
  final Ingredient? ingredientToUpdate;

  const AddIngredientScreen({super.key, this.ingredientToUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = context.read<AddIngredientBloc>();
        if (ingredientToUpdate != null) {
          bloc.add(InitializeForUpdate(ingredientToUpdate!));
        }
        return bloc;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(ingredientToUpdate == null ? 'Add Ingredient' : 'Edit Ingredient'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocConsumer<AddIngredientBloc, AddIngredientState>(
          listener: (context, state) {
            if (state is AddIngredientSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saved successfully!')),
              );
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is AddIngredientInitial) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImagePickerSection(
                      image: state.image,
                      onImagePicked: (bytes) => context.read<AddIngredientBloc>().add(ImageChanged(bytes)),
                    ),
                    const SizedBox(height: 32),
                    _BuildTextField(
                      label: 'Name',
                      initialValue: state.name,
                      onChanged: (v) => context.read<AddIngredientBloc>().add(NameChanged(v)),
                    ),
                    const SizedBox(height: 20),
                    _BuildTextField(
                      label: 'Description',
                      initialValue: state.description,
                      onChanged: (v) => context.read<AddIngredientBloc>().add(DescriptionChanged(v)),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    _BuildTextField(
                      label: 'Price',
                      initialValue: state.price == 0 ? '' : state.price.toString(),
                      onChanged: (v) => context.read<AddIngredientBloc>().add(PriceChanged(double.tryParse(v) ?? 0.0)),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: IngredientType.values.map((type) {
                        final isSelected = state.type == type;
                        return ChoiceChip(
                          label: Text(type.name.toUpperCase()),
                          selected: isSelected,
                          onSelected: (_) => context.read<AddIngredientBloc>().add(TypeChanged(type)),
                          selectedColor: Colors.deepOrange.shade100,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.isValid && !state.isSubmitting 
                          ? () => context.read<AddIngredientBloc>().add(SubmitForm()) 
                          : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: state.isSubmitting 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(state.isEdit ? 'Update Ingredient' : 'Add to Pantry'),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  final dynamic image; // Uint8List?
  final Function(dynamic) onImagePicked;

  const _ImagePickerSection({this.image, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            final bytes = await pickedFile.readAsBytes();
            onImagePicked(bytes);
          }
        },
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(image, fit: BoxFit.cover),
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Add Photo', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _BuildTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChanged;
  final int maxLines;
  final TextInputType keyboardType;

  const _BuildTextField({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
