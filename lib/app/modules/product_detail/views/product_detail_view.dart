import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';
import 'package:ssgc/app/modules/product_detail/views/pdf_view.dart';
import 'package:ssgc/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:ssgc/app/widgets/Shimmer/bottom_navigation_bar_shimmer.dart';
import 'package:ssgc/app/widgets/Shimmer/course_details_shimmer.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/buttons/custom_button_with_enable.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/app_image.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/text.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../cart/views/cart_view2.dart';
import '../../checkout/views/checkout_view.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  final int id;
  final String? type;
  const ProductDetailView({Key? key, required this.id, this.type})
      : super(key: key);
  Future<void> navigateToPaymentPage(BuildContext context) async {
    final route = MaterialPageRoute(
      builder: (context) => const CheckoutView(),
    );
    await Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    print("Received id $id");

    final ProductDetailController controller =
        Get.put(ProductDetailController());
    final AddressController addressController = Get.put(AddressController());
    final CartController cartController = Get.put(CartController());
    controller.fetchProductDetails(id);
    final WishlistController wishListController = Get.put(WishlistController());

    Future<bool> isBookInWishlist() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> wishlistIds = prefs.getStringList('itemId') ?? [];
      List<int> intWishlistIds =
          wishlistIds.map((id) => int.tryParse(id) ?? 0).toList();
      return intWishlistIds.contains(id);
    }

    navigateToCartPage() async {
      final route = MaterialPageRoute(
        builder: (context) => const CartView2(),
      );
      await Navigator.push(context, route);
      // await cartController.getCart();
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white50,
        title: BigText(text: "Books Details"),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              navigateToCartPage();
              // Get.to(()=> const CartView2());
              // print("Click");
              // await cartController.getCart();
              // await Get.to(CartView());
            },
            child: Container(
              width: 50,
              padding: const EdgeInsets.only(
                right: 12,
              ),
              margin: const EdgeInsets.only(right: 10),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    Positioned(
                      top: -10,
                      left: 15,
                      child: Container(
                        padding: EdgeInsets.all(
                          6,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.mainColor),
                        child: Obx(
                          () => Text(
                            cartController.cartQuantity.value.toString(),
                            style: TextStyle(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: controller.isLoading.value
          ? Container()
          : FloatingActionButton(
              backgroundColor: AppColor.mainColor,
              onPressed: () {},
              child: const Icon(
                Icons.question_answer_rounded,
                color: Colors.white,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading.value
                ? CourseDetailsShimmer()
                : Column(
                    children: <Widget>[
                      if (controller.productDetails.value.images!.isNotEmpty ||
                          controller.productDetails.value.images != null)
                        AppImageLoader(
                          imageUrl: controller.productDetails.value.images![0],
                          height: 250.h,
                          width: 210.w,
                        ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 10.h,
                        ),
                        padding: EdgeInsets.only(
                          top: 10.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.productDetails.value.name ??
                                  'No name found',
                              style: TextStyle(
                                fontSize: 20.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FutureBuilder(
                              future: isBookInWishlist(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Handle loading state if necessary
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Handle errors if necessary
                                  return Text(
                                      'Error is =================> ${snapshot.error}');
                                } else {
                                  return GetBuilder<WishlistController>(
                                    builder: (controller) {
                                      print(
                                          '================= Coming here =================');
                                      controller.isAddedToWishList.value =
                                          snapshot.data ?? false;
                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () async {
                                            if (controller
                                                    .isAddedToWishList.value ==
                                                false) {
                                              await wishListController
                                                  .addToWishList(id, type!);
                                              await Get.find<
                                                      ProductDetailController>()
                                                  .fetchProductDetails(id);
                                            } else {
                                              await controller
                                                  .deleteWishListFromProductDetails(
                                                      id);
                                              await controller
                                                  .removeFromWishlistSharedPreference(
                                                      id);
                                              await Get.find<
                                                      ProductDetailController>()
                                                  .fetchProductDetails(id);
                                            }
                                          },
                                          child: Icon(
                                            controller.isAddedToWishList.value
                                                ? Icons.favorite
                                                : Icons.favorite_border_rounded,
                                            color: controller
                                                    .isAddedToWishList.value
                                                ? Colors.red
                                                : Colors.black,
                                            // color: isAddedToWishlist ? Colors.red : null,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      // introduction content
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SmallText(
                                  text: "Sale Price: \u{20B9} ",
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SmallText(
                                  text: controller.productDetails.value.price
                                      .toString(),
                                  color: Colors.grey,
                                  size: 17,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Obx(
                              () => DefaultTabController(
                                length: 2, // Number of tabs
                                initialIndex: controller
                                    .currentIndex.value, // Initial tab index
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      labelColor: Colors.black,
                                      tabs: const [
                                        Tab(text: 'Features'),
                                        Tab(text: 'PDF'),
                                      ],
                                      onTap: (index) {
                                        controller.changeTab(index);
                                      },
                                    ),
                                    // TabBarView
                                    SizedBox(
                                      height: 80, // Adjust the height as needed
                                      child: TabBarView(
                                        children: [
                                          Row(
                                            children: [
                                              BigText(
                                                text: controller
                                                    .productDetails.value.name
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          // if(controller.productDetails.value.sample!.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(()=>PdfView());
                                              Get.to(() => PdfView(
                                                  pdf: controller.productDetails
                                                      .value.sample
                                                      .toString()));
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Text(controller
                                                            .productDetails
                                                            .value
                                                            .sample ??
                                                        '')),
                                                Icon(controller.productDetails
                                                        .value.sample
                                                        .toString()
                                                        .isEmpty
                                                    ? Icons
                                                        .picture_as_pdf_outlined
                                                    : null)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SmallText(
                              text:
                                  'Description: ${controller.productDetails.value.description.toString()}',
                              color: Colors.grey.shade800,
                              size: 14.h,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Divider(
                          thickness: 1.5.h,
                        ),
                      ),

                      Container(
                        height: 280.h,
                        margin: EdgeInsets.only(left: 10.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: "Related Product",
                                  size: 14.h,
                                ),
                                BigText(
                                  text: "View All",
                                  size: 14.h,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            SizedBox(
                              height: 230.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(right: 10.w),
                                itemCount: controller
                                    .productDetails.value.related!.length,
                                // itemCount: 5,
                                itemBuilder: (context, index) {
                                  final relatedBooks = controller
                                      .productDetails.value.related?[index];
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 130.w,
                                      margin: EdgeInsets.only(
                                        left: 8.w,
                                        right: 8.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(height: 150.h, width: 130.w, color: Colors.red,)
                                          AppImageLoader(
                                            imageUrl: relatedBooks?.image ??
                                                AppImage.noImage,
                                            height: 150.h,
                                            width: 130.w,
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            relatedBooks?.name ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.h,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            'Sale Price: ${relatedBooks?.mrp.toString() ?? ''}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.h,
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Divider(
                          thickness: 1.5.h,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            BigText(
                              text: "Comments",
                              size: 16.5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Obx(
                        () => controller.productDetails.value.reviews!.isEmpty
                            ? Text("No comments found")
                            : ListView.builder(
                                itemCount: controller
                                    .productDetails.value.reviews!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Text("Item ${index + 1}"),
                                  );
                                },
                              ),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                      // "Buy Now" button
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       // Add your "Buy Now" button action here
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColor.mainColor,
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           var linkurl = Uri.parse(
                      //               controller.productDetails.value.sample.toString());
                      //           launchUrl(linkurl, mode: LaunchMode.externalApplication,);
                      //         },
                      //         child: const Text(
                      //           "Download Pdf",
                      //           style: TextStyle(fontSize: 15, color: Colors.white),
                      //           // Customize the button text color
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
            // FutureBuilder(
            //     future: isBookInWishlist(),
            //     builder: (context, snapshot) {
            //       if(snapshot.connectionState == ConnectionState.waiting){
            //         return const Center(child: Center(child: CircularProgressIndicator()));
            //       }
            //       else if (snapshot.hasError) {
            //         return Text("Error: ${snapshot.error}");
            //       }
            //       else{
            //         final product = controller.productDetails.value;
            //         return ;
            //       }
            //     }
            // ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.isLoading.value
            ? BottomNavigationBarShimmer()
            : Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlineButton(
                        loading: false,
                        onPress: () async {
                          cartController.addToCart(id);
                          print("ID is  $id");
                        },
                        text: 'Add to cart',
                      ),
                    ),
                    Expanded(
                      child: RoundedButton(
                        isLoading: false,
                        text: 'Buy Now',
                        onPress: () {
                          navigateToPaymentPage(context);
                          print("buy now pressed");
                          // addressController.getAddress();
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class AboutText extends StatelessWidget {
  final String title;
  final String description;
  const AboutText({super.key, this.title = "", this.description = ""});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '\u2022 $title',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: description,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
