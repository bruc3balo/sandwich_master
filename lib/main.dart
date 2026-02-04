import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sandwich_master/core/di/injection.dart';
import 'package:sandwich_master/core/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive platform
  await Hive.initFlutter();
  
  // Initialize DI (This now handles adapters and boxes)
  await configureDependencies();
  
  runApp(const SandwichMaster());
}

class SandwichMaster extends StatelessWidget {
  const SandwichMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sandwich Master',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC6D13)),
        useMaterial3: true,
      ),
    );
  }
}
