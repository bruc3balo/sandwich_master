import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:form_ni_gani/core/di/injection.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_bloc.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_screen.dart';
import 'package:form_ni_gani/presentation/features/pantry/pantry_bloc.dart';
import 'package:form_ni_gani/presentation/features/pantry/pantry_screen.dart';

import 'package:form_ni_gani/presentation/features/splash/splash_screen.dart';
import 'package:form_ni_gani/presentation/features/sandwich_builder/sandwich_builder_bloc.dart';
import 'package:form_ni_gani/presentation/features/sandwich_builder/sandwich_builder_screen.dart';
import 'package:form_ni_gani/presentation/features/add_ingredient/add_ingredient_bloc.dart';
import 'package:form_ni_gani/presentation/features/add_ingredient/add_ingredient_screen.dart';
import 'package:form_ni_gani/domain/entities/ingredient.dart';

class AppRouter {
  static const String root = '/';
  static const String pantry = '/pantry';
  static const String splash = '/splash';
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
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SandwichBuilderBloc>(),
          child: const SandwichBuilderScreen(),
        ),
      ),
      GoRoute(
        path: addIngredient,
        builder: (context, state) {
          final ingredient = state.extra as Ingredient?;
          return BlocProvider(
            create: (context) => getIt<AddIngredientBloc>(),
            child: AddIngredientScreen(ingredientToUpdate: ingredient),
          );
        },
      ),
    ],
  );
}
