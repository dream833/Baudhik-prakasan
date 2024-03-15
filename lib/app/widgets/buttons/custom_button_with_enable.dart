import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWithEnable extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final double? height;

  const CustomButtonWithEnable({super.key, required this.text, required this.onPressed, required this.isEnabled, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        height: 45.h,
        decoration: BoxDecoration(
          color: isEnabled ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

