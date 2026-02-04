import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:form_ni_gani/core/di/injection.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_bloc.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_screen.dart';
import 'package:form_ni_gani/presentation/features/pantry/pantry_bloc.dart';
import 'package:form_ni_gani/presentation/features/pantry/pantry_screen.dart';

import 'package:form_ni_gani/presentation/features/splash/splash_screen.dart';

class AppRouter {
  static const String root = '/';
  static const String pantry = '/pantry';
  static const String splash = '/splash';

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
    ],
  );
}
