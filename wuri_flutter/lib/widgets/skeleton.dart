import 'package:flutter/material.dart';

import 'package:wuri_flutter/theme/app_theme.dart';

/// Fait légèrement pulser son contenu pendant le chargement.
class _Pulse extends StatefulWidget {
  const _Pulse({required this.child});

  final Widget child;

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.45, end: 1).animate(_controller),
      child: widget.child,
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.height, this.width, required this.radius});

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.sandDeep,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Fausses cartes d'espaces affichées pendant le chargement de la liste.
class SpaceListSkeleton extends StatelessWidget {
  const SpaceListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Pulse(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) => const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Box(height: 200, radius: 20),
            SizedBox(height: 12),
            _Box(height: 16, width: 180, radius: 8),
            SizedBox(height: 8),
            _Box(height: 12, width: 100, radius: 6),
          ],
        ),
      ),
    );
  }
}