import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';
import 'package:form_ni_gani/domain/entities/bread.dart';
import 'package:form_ni_gani/domain/entities/protein.dart';
import 'package:form_ni_gani/domain/entities/topping.dart';
import 'package:form_ni_gani/domain/entities/sauce.dart';
import 'package:form_ni_gani/domain/entities/ingredient_type.dart';
import 'package:form_ni_gani/presentation/widgets/component/image_card.dart';
import 'sandwich_builder_bloc.dart';
import 'sandwich_builder_event.dart';
import 'sandwich_builder_state.dart';

class SandwichBuilderScreen extends StatelessWidget {
  const SandwichBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<SandwichBuilderBloc>()..add(LoadIngredients()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Sandwich Lab', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<SandwichBuilderBloc, SandwichBuilderState>(
          listener: (context, state) {
            if (state is SandwichBuilderSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sandwich Saved!')),
              );
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is SandwichBuilderLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SandwichBuilderError) {
              return Center(child: Text(state.message));
            }

            if (state is SandwichBuilderReady) {
              return Column(
                children: [
                   Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _SandwichPreview(state: state),
                          const SizedBox(height: 32),
                          _NameInput(name: state.name),
                          const SizedBox(height: 24),
                          _IngredientSelector(state: state),
                        ],
                      ),
                    ),
                  ),
                  _BottomAction(state: state),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _SandwichPreview extends StatelessWidget {
  final SandwichBuilderReady state;
  const _SandwichPreview({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageCard(
          imageData: null, // We'll show the stack below instead
          height: 120,
          width: 200,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              if (state.bread != null) _StackLayer(ingredient: state.bread!, isTop: true),
              ...state.sauces.map((s) => _StackLayer(ingredient: s)),
              ...state.toppings.map((t) => _StackLayer(ingredient: t)),
              ...state.proteins.map((p) => _StackLayer(ingredient: p)),
              if (state.bread != null) _StackLayer(ingredient: state.bread!, isBottom: true),
              if (state.bread == null) 
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Select a bread to start building!', style: TextStyle(color: Colors.grey)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StackLayer extends StatelessWidget {
  final Ingredient ingredient;
  final bool isTop;
  final bool isBottom;

  const _StackLayer({required this.ingredient, this.isTop = false, this.isBottom = false});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    switch (ingredient.type) {
      case IngredientType.bread: color = Colors.orange.shade300; break;
      case IngredientType.protein: color = Colors.red.shade400; break;
      case IngredientType.topping: color = Colors.green.shade400; break;
      case IngredientType.sauce: color = Colors.yellow.shade700; break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      height: (isTop || isBottom) ? 20 : 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(isTop || isBottom ? 15 : 6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          ingredient.name.toUpperCase(),
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: color.computeLuminance() > 0.5 ? Colors.black54 : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  final String name;
  const _NameInput({required this.name});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (val) => context.read<SandwichBuilderBloc>().add(UpdateName(val)),
      decoration: InputDecoration(
        labelText: 'Sandwich Name',
        hintText: 'e.g. The Mighty Club',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}

class _IngredientSelector extends StatelessWidget {
  final SandwichBuilderReady state;
  const _IngredientSelector({required this.state});

  @override
  Widget build(BuildContext context) {
    final types = IngredientType.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: types.map((type) {
        final filtered = state.availableIngredients.where((i) => i.type == type).toList();
        if (filtered.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                type.name.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filtered.length,
                separatorBuilder: (context, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final ingredient = filtered[index];
                  final isSelected = _isIngredientSelected(ingredient);

                  return _IngredientTile(
                    ingredient: ingredient,
                    isSelected: isSelected,
                    onTap: () => _handleIngredientToggle(context, ingredient),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  bool _isIngredientSelected(Ingredient ingredient) {
    if (ingredient is Bread) return state.bread == ingredient;
    if (ingredient is Protein) return state.proteins.contains(ingredient);
    if (ingredient is Topping) return state.toppings.contains(ingredient);
    if (ingredient is Sauce) return state.sauces.contains(ingredient);
    return false;
  }

  void _handleIngredientToggle(BuildContext context, Ingredient ingredient) {
    final bloc = context.read<SandwichBuilderBloc>();
    if (ingredient is Bread) bloc.add(SelectBread(ingredient));
    if (ingredient is Protein) bloc.add(ToggleProtein(ingredient));
    if (ingredient is Topping) bloc.add(ToggleTopping(ingredient));
    if (ingredient is Sauce) bloc.add(ToggleSauce(ingredient));
  }
}

class _IngredientTile extends StatelessWidget {
  final Ingredient ingredient;
  final bool isSelected;
  final VoidCallback onTap;

  const _IngredientTile({required this.ingredient, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.deepOrange : Colors.grey.shade200, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ingredient.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text('\$${ingredient.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  final SandwichBuilderReady state;
  const _BottomAction({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('TOTAL PRICE', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                Text('\$${state.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: state.isValid && !state.isSaving 
                  ? () => context.read<SandwichBuilderBloc>().add(SaveSandwichEvent()) 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: state.isSaving 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Save Creation', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
