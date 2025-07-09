import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox.expand(
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              isDarkMode? 'lib/asset/image/bg_dark2.png' :
              'lib/asset/image/bg_light2 - 1.png',
              fit: BoxFit.cover, // <- fills and crops to cover
            ),
          ),
          // Foreground content
          child,
        ],
      ),
    );
  }
}
