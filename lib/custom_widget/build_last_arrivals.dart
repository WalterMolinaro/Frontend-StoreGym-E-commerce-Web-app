
import 'package:flutter/material.dart';

class BuildLastArrivals extends StatelessWidget {
  final Image image;
  final Text title;
  final Text description;
  final Text price;
  final VoidCallback onTap;

  const BuildLastArrivals({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Card(
                  child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: image,
                    ),
                    Wrap(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: title,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: description,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: price,
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
