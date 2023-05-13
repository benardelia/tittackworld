import 'package:flutter/material.dart';
import 'package:ticktackworld/main.dart';

class CustomText extends StatelessWidget {
 const CustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 20, color: Colors.white)]),
    );
  }
}
