import 'package:flutter/material.dart';
import 'package:slicky/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Pallete.blackColor,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                descriptionText,
                style: const TextStyle(
                  color: Pallete.blackColor,
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
