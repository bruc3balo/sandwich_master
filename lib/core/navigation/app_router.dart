import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sandwich_master/core/di/injection.dart';
import 'package:sandwich_master/presentation/features/menu_gallery/menu_gallery_bloc.dart';
import 'package:sandwich_master/presentation/features/menu_gallery/menu_gallery_screen.dart';
import 'package:sandwich_master/presentation/features/pantry/pantry_bloc.dart';
import 'package:sandwich_master/presentation/features/pantry/pantry_screen.dart';

import 'package:sandwich_master/presentation/features/splash/splash_screen.dart';
import 'package:sandwich_master/presentation/features/sandwich_builder/sandwich_builder_bloc.dart';
import 'package:sandwich_master/presentation/features/sandwich_builder/sandwich_builder_screen.dart';
import 'package:sandwich_master/presentation/features/sandwich_builder/sandwich_builder_event.dart';
import 'package:sandwich_master/domain/entities/sandwich.dart';
import 'package:sandwich_master/presentation/features/add_ingredient/add_ingredient_bloc.dart';
import 'package:sandwich_master/presentation/features/add_ingredient/add_ingredient_event.dart';
import 'package:sandwich_master/presentation/features/add_ingredient/add_ingredient_screen.dart';
import 'package:sandwich_master/domain/entities/ingredient.dart';
import 'package:sandwich_master/presentation/features/welcome/welcome_screen.dart';

class AppRouter {
  static const String root = '/';
  static const String pantry = '/pantry';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String builder = '/builder';
  static const String addIngredient = '/add-ingredient';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: root,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => getIt<MenuGalleryBloc>(),
              child: const MenuGalleryScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: pantry,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<PantryBloc>(),
          child: const PantryScreen(),
        ),
      ),
      GoRoute(
        path: builder,
        builder: (context, state) {
          final sandwich = state.extra as Sandwich?;
          return BlocProvider(
            create: (context) {
              final bloc = getIt<SandwichBuilderBloc>()..add(LoadIngredients());
              if (sandwich != null) {
                bloc.add(InitializeForEdit(sandwich));
              }
              return bloc;
            },
            child: const SandwichBuilderScreen(),
          );
        },
      ),
      GoRoute(
        path: addIngredient,
        builder: (context, state) {
          final ingredient = state.extra as Ingredient?;
          return BlocProvider(
            create: (context) {
              final bloc = getIt<AddIngredientBloc>();
              if (ingredient != null) {
                bloc.add(InitializeForUpdate(ingredient));
              }
              return bloc;
            },
            child: AddIngredientScreen(ingredientToUpdate: ingredient),
          );
        },
      ),
    ],
  );
}
