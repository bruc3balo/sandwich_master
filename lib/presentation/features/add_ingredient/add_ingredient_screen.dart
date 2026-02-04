import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';
import 'package:sandwich_master/presentation/widgets/component/image_card.dart';
import 'add_ingredient_bloc.dart';
import 'add_ingredient_event.dart';
import 'add_ingredient_state.dart';

class AddIngredientScreen extends StatefulWidget {
  final Ingredient? ingredientToUpdate;

  const AddIngredientScreen({super.key, this.ingredientToUpdate});

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredientToUpdate?.name ?? '');
    _descriptionController = TextEditingController(text: widget.ingredientToUpdate?.description ?? '');
    _priceController = TextEditingController(
      text: widget.ingredientToUpdate != null ? widget.ingredientToUpdate!.price.toString() : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.ingredientToUpdate == null ? 'Add Ingredient' : 'Edit Ingredient'),
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
          if (state is AddIngredientError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
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
                    controller: _nameController,
                    onChanged: (v) => context.read<AddIngredientBloc>().add(NameChanged(v)),
                  ),
                  const SizedBox(height: 20),
                  _BuildTextField(
                    label: 'Description',
                    controller: _descriptionController,
                    onChanged: (v) => context.read<AddIngredientBloc>().add(DescriptionChanged(v)),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  _BuildTextField(
                    label: 'Price',
                    controller: _priceController,
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
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(state.isEdit ? 'Update Ingredient' : 'Add to Pantry'),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  final dynamic image;
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
  final TextEditingController controller;
  final Function(String) onChanged;
  final int maxLines;
  final TextInputType keyboardType;

  const _BuildTextField({
    required this.label,
    required this.controller,
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
          controller: controller,
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
