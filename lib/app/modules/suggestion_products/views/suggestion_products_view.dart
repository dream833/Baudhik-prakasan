import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/rating.dart';

import '../../../data/app_image.dart';
import '../../../utils/categories.dart';
import '../../../widgets/text.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../controllers/suggestion_products_controller.dart';

class SuggestionProductsView extends GetView<SuggestionProductsController> {
  final String text;
  const SuggestionProductsView({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            BigText(
              text: text,
              size: 15,
            ),
            Container(
              height: 250,
              child: ListView.builder(
                  itemCount: Categories.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.to(() => const ProductDetailView(id: 30,));
                      },
                      child: SuggestionProductCard(index: index))),
            )
          ],
        ),
      ),
    );
  }
}

class SuggestionProductCard extends StatelessWidget {
  final int index;

  const SuggestionProductCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(1, 1)),
              ],
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(AppImage.demo), fit: BoxFit.fitHeight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: Categories.categories[index].title,
                  size: 15,
                ),
                Rating(),
                Row(
                  children: [
                    SmallText(
                      text: "Sale Price: \u{20B9} 100",
                      color: AppColor.mainColor,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
