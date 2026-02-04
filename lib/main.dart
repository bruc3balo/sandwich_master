import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:form_ni_gani/core/di/injection.dart';
import 'package:form_ni_gani/data/models/ingredient_model.dart';
import 'package:form_ni_gani/data/models/sandwich_model.dart';
import 'package:form_ni_gani/data/models/ingredient_type_model.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_screen.dart';
import 'package:form_ni_gani/presentation/features/menu_gallery/menu_gallery_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive platform
  await Hive.initFlutter();
  
  // Initialize DI (This now handles adapters and boxes)
  await configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Ni Gani?',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<MenuGalleryBloc>(),
        child: const MenuGalleryScreen(),
      ),
    );
  }
}
