import 'package:flutter/material.dart';

class BuildCategories extends StatelessWidget {
  final VoidCallback onTap;
  final Text text;
  final String pathImage;
  const BuildCategories({
    required this.onTap,
    required this.text,
    required this.pathImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(pathImage, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
