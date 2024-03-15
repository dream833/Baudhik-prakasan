import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/all_products/views/all_products_view.dart';
import 'package:ssgc/app/modules/product_detail/views/product_detail_view.dart';

import '../../../utils/categories.dart';
import '../../../widgets/text.dart';
import '../controllers/catalog_product_controller.dart';

class CatalogProductView extends GetView<CatalogProductController> {
  final String text;
  const CatalogProductView({
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
            Padding(
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
                      Get.to(() =>  AllProductsView());
                    },
                    child: SmallText(
                      text: "View all",
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            // Fetch data from API
            SizedBox(
              height: 210,
              child: ListView.builder(
                itemCount: Categories.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const ProductDetailView(id: 30,));
                    },
                    child: CatalogProductCard(index: index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CatalogProductCard extends StatelessWidget {
  final int index;

  const CatalogProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/images/book1.png"),
          // image: AssetImage(Categories.categories[index].imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   Padding(
        //     padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        //     child: Column(
        //       children: [
        //         BigText(
        //           text: Categories.categories[index].title,
        //           size: 15,
        //         )
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
