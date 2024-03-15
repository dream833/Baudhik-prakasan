import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/app_color.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double height;

  const CustomVerticalDivider({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.mainColor,
      ),
    );
  }
}
