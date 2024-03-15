import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/app_color.dart';

class PriceText extends StatelessWidget {
  final String text;
  const PriceText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColor.mainColor
      ),
    );
  }
}
