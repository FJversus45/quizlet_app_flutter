import 'package:flutter/material.dart';

class PageRouter extends PageRouteBuilder {
  final Widget child;

  PageRouter({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 650),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      FadeTransition(opacity: animation, child: child);
}
