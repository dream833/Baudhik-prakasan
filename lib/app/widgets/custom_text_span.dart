import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {

  final String title;
  final String text;

  const CustomTextSpan({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.teal,
                ),
              )
            ]
        )
    );
  }
}
