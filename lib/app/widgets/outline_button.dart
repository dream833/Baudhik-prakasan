import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/app_color.dart';

class OutlineButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final double? height;
  final double? width;
  final double borderRadius;
  final bool loading;
  const OutlineButton({super.key, required this.onPress, required this.text, this.height = 45, this.width, this.borderRadius = 10, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 6,
          bottom: 6,
        ),
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: AppColor.mainColor
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: loading == false
              ? Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ): CircularProgressIndicator(),
        ),
      ),
    );
  }
}
