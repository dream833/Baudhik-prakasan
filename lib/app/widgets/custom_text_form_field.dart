import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final bool? isObscure;
  final String? emptyMessage;
  final IconData? suffixIcon;
  final VoidCallback? suffixOnPress;
  final String label;
  final TextInputType? inputType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.currentFocus,
    this.nextFocus,
    this.isObscure = false,
    this.emptyMessage = "",
    required this.label,
    this.inputType,
    this.suffixIcon,
    this.suffixOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
      ),
      child: TextFormField(
        focusNode: currentFocus,
        controller: controller,
        obscureText: isObscure!,
        keyboardType: inputType,
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          suffixIcon: GestureDetector(
            onTap: suffixOnPress,
            child: Icon(suffixIcon),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return emptyMessage;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          Utils.fieldFocusChange(
            context,
            currentFocus,
            nextFocus!,
          );
        },
      ),
    );
  }
}
