import 'package:flutter/material.dart';

class SlideLeftPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlideLeftPageRoute({required this.builder})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 140),
        );
}

class SlideRightPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlideRightPageRoute({required this.builder})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                  reverseCurve: Curves.easeOut,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 140),
        );
}
