import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextDecoration textDecoration;
  final TextOverflow overflow;
  SmallText({
    super.key,
    // this.color = const Color(0xFFccc7c5),
    this.color = const Color(0xFF21130d),
    required this.text,
    this.size = 13,
    this.height = 1.2,
    this.textDecoration = TextDecoration.none,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.openSans(
          // text-decoration: TextDecoration(),
          textStyle: TextStyle(
            decoration: textDecoration,
            color: color,
            fontSize: size,
            height: height,
          ),
        ));
  }
}

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextDecoration textDecoration;
  BigText({
    super.key,
    this.color = Colors.black,
    required this.text,
    this.size = 20,
    this.height = 1.2,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        // text-decoration: TextDecoration(),
        textStyle: TextStyle(
          decoration: textDecoration,
          color: color,
          fontSize: size,
          height: height,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
