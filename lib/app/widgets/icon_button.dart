import 'package:flutter/material.dart';

import 'app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColor.mainColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: Offset(1, 1)),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.notifications_active_outlined,
          color: Colors.white,
        ));
  }
}
