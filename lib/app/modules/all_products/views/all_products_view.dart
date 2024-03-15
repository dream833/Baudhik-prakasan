import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../widgets/image_loader.dart';
import '../../../widgets/outline_button.dart';
import '../../detail_page/controllers/detail_page_controller.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../controllers/all_products_controller.dart';

class AllProductsView extends GetView<AllProductsController> {
  int? index;
  int? id;
  String? language;
  String? type;
  AllProductsView({super.key, this.index, this.id, this.language, this.type});
  @override
  Widget build(BuildContext context) {
    DetailPageController controller = Get.put(DetailPageController());
    controller.fetchCategoryWiseBook(id!, language!, type!);

    print("All product page received id ----------> $id");
    print("All product page received Language ----------> $language");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'All Products',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Obx(
          () => controller.isCategoryWiseBookLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.categoryWiseBookList.isEmpty
                  ? const Center(
                      child: Text("No data found"),
                    )
                  : ListView.builder(
                      itemCount: controller.categoryWiseBookList.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        final category = controller.categoryWiseBookList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ProductDetailView(
                                id: category.id, type: type!));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppImageLoader(
                                      imageUrl: category.image,
                                      height: 100,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(category.name),
                                        Text("Mrp. ${category.mrp}"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            OutlineButton(
                                              onPress: () {},
                                              text: 'Add to cart',
                                            ),
                                            RoundedButton(
                                              isLoading: false,
                                              text: 'Buy Now',
                                              onPress: () {},
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.teal,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
