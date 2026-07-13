import 'package:flutter/material.dart';

import '../../../theme/theme_extensions.dart';
import '../widgets/png_loading.dart';

/// A comprehensive loading page demonstrating various PNG loading animations.
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        title: const Text('Loading Animations'),
        backgroundColor: context.colors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, 'Frame Animation', children: [
            const Center(
              child: PngLoadingDual(
                darkImagePath: 'assets/image/RESC-dark.png',
                lightImagePath: 'assets/image/RESC-ligh.png',
                frameDuration: Duration(milliseconds: 600),
                size: 200,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          _section(theme, 'Multiple Animations', children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPulsingLogo(80),
                _buildPulsingLogo(60),
                _buildPulsingLogo(40),
              ],
            ),
          ]),
          _section(theme, 'Continuous Pulse', children: [
            const Center(
              child: PngLoadingPulse(
                imagePath: 'assets/image/RESC-dark.png',
                size: 150,
                pulseDuration: Duration(milliseconds: 1000),
              ),
            ),
          ]),
          _section(theme, 'Fade Animation', children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PngLoadingFade(
                  imagePath: 'assets/image/RESC-dark.png',
                  size: 60,
                  fadeDuration: const Duration(milliseconds: 300),
                ),
                PngLoadingFade(
                  imagePath: 'assets/image/RESC-dark.png',
                  size: 80,
                  fadeDuration: const Duration(milliseconds: 500),
                ),
                PngLoadingFade(
                  imagePath: 'assets/image/RESC-dark.png',
                  size: 100,
                  fadeDuration: const Duration(milliseconds: 700),
                ),
              ],
            ),
          ]),
          _section(theme, 'Custom Frame Animation', children: [
            const Center(
              child: PngLoading(
                imagePaths: [
                  'assets/image/RESC-dark.png',
                  'assets/image/RESC-ligh.png',
                ],
                frameDuration: Duration(milliseconds: 400),
                size: 180,
                curve: Curves.easeInOut,
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPulsingLogo(double size) {
    return PngLoadingFade(
      imagePath: 'assets/image/RESC-dark.png',
      size: size,
      fadeDuration: const Duration(milliseconds: 500),
    );
  }

  Widget _section(ThemeData theme, String title,
      {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
