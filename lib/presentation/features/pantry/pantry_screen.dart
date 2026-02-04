import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';
import 'package:form_ni_gani/presentation/widgets/component/ingredient_card.dart';
import 'package:go_router/go_router.dart';
import 'package:form_ni_gani/core/navigation/app_router.dart';
import 'pantry_bloc.dart';
import 'pantry_event.dart';
import 'pantry_state.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Pantry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _SearchBar(),
          _CategoryFilters(),
          Expanded(
            child: BlocBuilder<PantryBloc, PantryState>(
              builder: (context, state) {
                if (state is PantryInitial) {
                  context.read<PantryBloc>().add(const FetchIngredients());
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PantryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PantryError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                if (state is PantryLoaded) {
                  if (state.filteredIngredients.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          const Text('No ingredients found.'),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: state.filteredIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = state.filteredIngredients[index];
                      return _PantryIngredientItem(ingredient: ingredient);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(AppRouter.addIngredient);
          if (context.mounted) {
            context.read<PantryBloc>().add(const FetchIngredients());
          }
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (value) {
          context.read<PantryBloc>().add(SearchIngredients(value));
        },
        decoration: InputDecoration(
          hintText: 'Search ingredients...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PantryBloc, PantryState>(
      builder: (context, state) {
        final selectedType = (state is PantryLoaded) ? state.selectedType : null;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                isSelected: selectedType == null,
                onTap: () => context.read<PantryBloc>().add(const FilterByType(null)),
              ),
              ...IngredientType.values.map((type) {
                return _FilterChip(
                  label: type.name.toUpperCase(),
                  isSelected: selectedType == type,
                  onTap: () => context.read<PantryBloc>().add(FilterByType(type)),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: Colors.black87,
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        showCheckmark: false,
      ),
    );
  }
}

class _PantryIngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const _PantryIngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IngredientCard(ingredient: ingredient),
        Positioned(
          top: 8,
          right: 8,
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
            onSelected: (value) {
              if (value == 'delete') {
                _confirmDelete(context);
              } else if (value == 'edit') {
                context.push(AppRouter.addIngredient, extra: ingredient).then((_) {
                  if (context.mounted) {
                    context.read<PantryBloc>().add(const FetchIngredients());
                  }
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove from Pantry?'),
        content: Text('Are you sure you want to delete "${ingredient.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<PantryBloc>().add(DeleteIngredientEvent(ingredient.id));
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
