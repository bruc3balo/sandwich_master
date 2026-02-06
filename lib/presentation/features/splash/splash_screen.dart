import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sandwich_master/core/navigation/app_router.dart';
import 'package:sandwich_master/core/di/injection.dart';
import 'package:sandwich_master/domain/repositories/settings_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _topBreadPos;
  late Animation<double> _cheesePos;
  late Animation<double> _lettucePos;
  late Animation<double> _bottomBreadPos;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Stacking animation offsets
    _topBreadPos = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.bounceOut)),
    );
    _lettucePos = Tween<double>(begin: -80, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.bounceOut)),
    );
    _cheesePos = Tween<double>(begin: -60, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.bounceOut)),
    );
    _bottomBreadPos = Tween<double>(begin: -40, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.bounceOut)),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Navigate after 2.5 seconds (animation + pause)
    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (mounted) {
        final isFirstRun = await getIt<SettingsRepository>().isFirstRun();
        if (mounted) {
          context.go(isFirstRun ? AppRouter.welcome : AppRouter.root);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sunsetOrange = Color(0xFFEC6D13);

    return Scaffold(
      backgroundColor: sunsetOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _opacity,
              child: SizedBox(
                height: 200,
                width: 200,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Bottom Bread
                        Transform.translate(
                          offset: Offset(0, _bottomBreadPos.value),
                          child: _IngredientIcon(Icons.rectangle, Colors.orange.shade300, 100, 20),
                        ),
                        // Cheese
                        Transform.translate(
                          offset: Offset(0, _cheesePos.value - 15),
                          child: _IngredientIcon(Icons.rectangle, Colors.yellow.shade600, 90, 10),
                        ),
                        // Lettuce
                        Transform.translate(
                          offset: Offset(0, _lettucePos.value - 30),
                          child: _IngredientIcon(Icons.waves, Colors.green.shade400, 95, 15),
                        ),
                        // Top Bread
                        Transform.translate(
                          offset: Offset(0, _topBreadPos.value - 45),
                          child: _IngredientIcon(Icons.rectangle, Colors.orange.shade300, 100, 20),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeTransition(
              opacity: _opacity,
              child: const Text(
                'Sandwich Master',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeTransition(
              opacity: _opacity,
              child: Text(
                'CRAFT YOUR PERFECT BITE',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double width;
  final double height;

  const _IngredientIcon(this.icon, this.color, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
