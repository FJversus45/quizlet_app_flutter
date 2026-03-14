import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class PageLoader extends StatelessWidget {
  final String? message;
  final Color? color;
  const PageLoader({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Container(
          // height: 45,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.discreteCircle(
                size: 35,
                color: color ?? Color(0xFF3E2F8A),
              ),
              if (message != null) ...[
                Gap(12),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PageLoaderWithPadding extends StatelessWidget {
  final String? message;
  const PageLoaderWithPadding({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              Gap(12),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PageLoaderWithScaffold extends StatelessWidget {
  final String? message;
  const PageLoaderWithScaffold({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.05),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              Gap(12),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PageLoaderOverlay extends StatelessWidget {
  final String? message;
  const PageLoaderOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.discreteCircle(
                size: 35,
                color: Theme.of(context).primaryColor,
              ),
              if (message != null) ...[
                const SizedBox(height: 12),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
