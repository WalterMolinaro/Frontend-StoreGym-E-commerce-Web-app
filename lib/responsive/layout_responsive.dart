import 'package:flutter/material.dart';

class LayoutResponsive extends StatelessWidget {
  final Widget tablet;
  final Widget desktop;

  const LayoutResponsive(
      {Key? key, required this.desktop, required this.tablet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000) {
        return tablet;
      } else
        return desktop;
    });
  }
}
