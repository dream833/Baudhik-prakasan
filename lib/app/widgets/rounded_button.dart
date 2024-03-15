import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/app_color.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double borderRadius;
  final bool? isLoading;
  const RoundedButton({
    super.key,
    required this.text,
    required this.onPress,
    this.height = 45,
    this.width,
    this.backgroundColor = Colors.teal,
    this.borderRadius = 10,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 6,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Center(
          child: isLoading == false
              ? Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColor.white,
                ),
        ),
      ),
    );
  }
}
