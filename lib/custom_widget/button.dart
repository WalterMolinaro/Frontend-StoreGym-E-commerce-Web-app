import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Text text;
  final int sizeIcon;
  final VoidCallback? onPressed;
  final IconData? iconData;

  const Button(
      {this.iconData,
      Key? key,
      required this.text,
      this.sizeIcon = 20,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        this.iconData,
        size: this.sizeIcon.toDouble(),
      ),
      onPressed: this.onPressed,
      label: this.text,
    );
  }
}
