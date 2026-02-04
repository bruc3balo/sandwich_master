import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/domain/entities/ingredient_type.dart';
import 'package:sandwich_master/presentation/widgets/component/image_card.dart';
import 'package:go_router/go_router.dart';
import 'package:sandwich_master/core/navigation/app_router.dart';
import 'menu_gallery_bloc.dart';
import 'menu_gallery_event.dart';
import 'menu_gallery_state.dart';

class MenuGalleryScreen extends StatelessWidget {
  const MenuGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Sandwich Gallery',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.inventory_2_outlined, color: Colors.black87),
            onPressed: () {
              context.push(AppRouter.pantry);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<MenuGalleryBloc, MenuGalleryState>(
        builder: (context, state) {
          if (state is MenuGalleryInitial) {
            context.read<MenuGalleryBloc>().add(const FetchSandwiches());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MenuGalleryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MenuGalleryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<MenuGalleryBloc>().add(const FetchSandwiches(refresh: true)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is MenuGalleryLoaded) {
            if (state.sandwiches.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    const Text('No sandwiches in your collection yet!'),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<MenuGalleryBloc>().add(const FetchSandwiches(refresh: true));
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.sandwiches.length,
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final sandwich = state.sandwiches[index];
                  return _SandwichGalleryCard(sandwich: sandwich);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push(AppRouter.builder);
          if (context.mounted) {
            context.read<MenuGalleryBloc>().add(const FetchSandwiches(refresh: true));
          }
        },
        label: const Text('Create New'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}

class _SandwichGalleryCard extends StatelessWidget {
  final Sandwich sandwich;

  const _SandwichGalleryCard({required this.sandwich});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCard(
            imageData: sandwich.image,
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        sandwich.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                    ),
                    Text(
                      '\$${sandwich.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'COMPOSITION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                _VisualStack(sandwich: sandwich),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                      onPressed: () => context.push(AppRouter.builder, extra: sandwich),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.grey),
                      onPressed: () => _confirmDelete(context),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Cook Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Sandwich'),
        content: Text('Are you sure you want to delete "${sandwich.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MenuGalleryBloc>().add(DeleteSandwichEvent(sandwich.id));
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _VisualStack extends StatelessWidget {
  final Sandwich sandwich;

  const _VisualStack({required this.sandwich});

  @override
  Widget build(BuildContext context) {
    // Reverse order for a bottom-up stack visualization
    final allLayers = [
      sandwich.bread,
      ...sandwich.proteins,
      ...sandwich.toppings,
      ...sandwich.sauces,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: allLayers.map((ingredient) => _StackPill(ingredient: ingredient)).toList(),
    );
  }
}

class _StackPill extends StatelessWidget {
  final Ingredient ingredient;

  const _StackPill({required this.ingredient});

  Color _getTypeColor() {
    switch (ingredient.type) {
      case IngredientType.bread:
        return Colors.green;
      case IngredientType.protein:
        return Colors.red;
      case IngredientType.topping:
        return Colors.orange;
      case IngredientType.sauce:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            ingredient.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: (color as MaterialColor).shade900,
            ),
          ),
        ],
      ),
    );
  }
}
