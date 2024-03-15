import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/text.dart';

import '../modules/all_products/views/all_products_view.dart';
import 'package:get/get.dart';

class TitleAndViewAll extends StatelessWidget {
  final String text;
  final int index;
  const TitleAndViewAll({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    print("My received index is $index");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(
            text: text,
            size: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AllProductsView());
            },
            child: SmallText(
              text: "View all",
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
