import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';
import 'package:ssgc/app/modules/cart/controllers/cart_controller.dart';
import 'package:ssgc/app/modules/cart/views/cart_view.dart';
import 'package:ssgc/app/modules/cart/views/cart_view2.dart';
import 'package:ssgc/app/modules/courses/controllers/courses_controllers.dart';
import 'package:ssgc/app/modules/courses/views/video_play.dart';
import 'package:ssgc/app/widgets/Shimmer/course_details_shimmer.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ssgc/app/widgets/rating.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../widgets/Shimmer/bottom_navigation_bar_shimmer.dart';
import '../../../widgets/dialog/buy_dialog.dart';
import '../../../widgets/outline_button.dart';
import '../../buy_now/views/buy_now_view.dart';
import '../../product_detail/views/pdf_view.dart';

class CourseDetailsView extends StatelessWidget {
  final int id;
  const CourseDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoursesController());
    PageController pageController = PageController(initialPage: 0);
    final AddressController addressController = Get.put(AddressController());
    final CartController cartController = Get.put(CartController());
    controller.getCourseDetails(id);
    controller.getCourseVideo(id);

    Future<void> navigateToPaymentPage(BuildContext context) async {
      // final route = MaterialPageRoute(
      //   builder: (context) => const BuyNowView(),
      // );
      // await Navigator.push(context, route);
      Get.to(() => const BuyNowView(), arguments: {
        'image': controller.courseDetails.value!.images![0],
        'name': controller.courseDetails.value!.name,
        'price': controller.courseDetails.value!.mrp.toString(),
      });
    }

    onRefresh() async {
      controller.getCourseDetails(id);
    }

    Future<void> navigateToCartPage() async {
      Get.to(() {
        return const CartView();
      });
      final cartController = Get.find<CartController>();
      await cartController.getCart();
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
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
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    Positioned(
                      top: -10,
                      left: 15,
                      child: Container(
                        padding: const EdgeInsets.all(
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
        title: Text(
          "Course Details",
          style: TextStyle(color: AppColor.black),
        ),
        iconTheme: IconThemeData(color: AppColor.black),
        backgroundColor: AppColor.white50,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Obx(
              () => controller.isCourseDetailsLoading.value
                  ? CourseDetailsShimmer()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.courseDetails.value!.images!.isEmpty
                            ? Container()
                            : Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: controller
                                        .courseDetails.value?.images!.length,
                                    options: CarouselOptions(
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.9,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        initialPage:
                                            controller.currentIndex.value,
                                        onPageChanged: (index, reason) {
                                          controller.currentIndex.value = index;
                                        }),
                                    itemBuilder: (context, index, realIndex) {
                                      final imageUrl = controller
                                          .courseDetails.value?.images![index];
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              imageUrl ?? AppImage.noImage,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    child: buildIndicator(),
                                  ),
                                ],
                              ),

                        // buildIndicator(),
                        SizedBox(
                          height: 16.h,
                        ),

                        // Name
                        Text(
                          controller.courseDetails.value?.name.toString() ?? '',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        //   Price mrp
                        Text(
                          'MRP: ${controller.courseDetails.value?.mrp ?? 'N/A'}',
                        ),
                        // sale price
                        Text(
                          'Sale Price: ${controller.courseDetails.value?.mrp.toString()}',
                        ),

                        SizedBox(
                          height: 10.h,
                        ),

                        Divider(
                          thickness: 1.5.h,
                        ),

                        SizedBox(
                          height: 16.h,
                        ),

                        // Tab bar features and video/test/pdf

                        Obx(
                          () => SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.selectedItem.value = 0;
                                    print('Features');
                                  },
                                  child: Text(
                                    "Featues",
                                    style: TextStyle(
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                            color:
                                                controller.selectedItem.value ==
                                                        0
                                                    ? Colors.red
                                                    : Colors.teal,
                                            offset: Offset(0, -5))
                                      ],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          controller.selectedItem.value == 0
                                              ? TextDecoration.underline
                                              : null,
                                      decorationColor: Colors.grey,
                                      decorationThickness: 4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.selectedItem.value = 1;
                                    print('Video test');
                                  },
                                  child: Text(
                                    "Video/ PDF/ Test",
                                    style: TextStyle(
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                            color:
                                                controller.selectedItem.value ==
                                                        1
                                                    ? Colors.red
                                                    : Colors.teal,
                                            offset: Offset(0, -5))
                                      ],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          controller.selectedItem.value == 1
                                              ? TextDecoration.underline
                                              : null,
                                      decorationColor: Colors.grey,
                                      decorationThickness: 4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (controller.selectedItem.value == 0)
                          Text(
                            controller.courseDetails.value?.description
                                    .toString() ??
                                '',
                          ),

                        if (controller.selectedItem.value == 1)
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.isCourseDetailsLoading.value
                                    ? const CircularProgressIndicator()
                                    : controller.courseDetails.value!.videos!
                                            .isNotEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Video',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.h,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              ListView.builder(
                                                itemCount: controller
                                                    .courseDetails
                                                    .value
                                                    ?.videos
                                                    ?.length,
                                                primary: false,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  final videoList = controller
                                                      .courseDetails
                                                      .value
                                                      ?.videos?[index];
                                                  // final videos = controller.videoModel.value.videos!;
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  videoList?.dayNo ==
                                                                          0
                                                                      ? Icons
                                                                          .lock_open
                                                                      : Icons
                                                                          .lock,
                                                                  color: videoList
                                                                              ?.dayNo ==
                                                                          0
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .black,
                                                                  size: 25.h,
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      videoList?.dayNo ==
                                                                              0
                                                                          ? VideoPlay(
                                                                              url: videoList?.link ??
                                                                                  'No url found')
                                                                          : CustomAlertDialog(context)
                                                                              .show(
                                                                              onConfirm: () {
                                                                                // Perform action when OK button is pressed
                                                                              },
                                                                              onCancel: () {
                                                                                // Perform action when Cancel button is pressed
                                                                              },
                                                                            );
                                                                    },
                                                                    child: Text(
                                                                      '${index + 1}. ${videoList?.title ?? ''}',
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.h,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          videoList?.dayNo == 0
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                      VideoPlay(
                                                                          url: videoList?.link ??
                                                                              'No url found'),
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .smart_display_rounded,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 25.h,
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        height: 12.h,
                                                      ),

                                                      // Text('link: ${videoList?.link ?? ''}'),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                if (controller
                                    .courseDetails.value!.pdfs!.isNotEmpty)
                                  Divider(
                                    thickness: 1.5.h,
                                  ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                controller.courseDetails.value!.pdfs!.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pdf',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.h,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          ListView.builder(
                                            itemCount: controller.courseDetails
                                                .value?.pdfs?.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final pdfList = controller
                                                  .courseDetails
                                                  .value
                                                  ?.pdfs?[index];
                                              // final videos = controller.videoModel.value.videos!;
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              pdfList?.dayNo ==
                                                                      0
                                                                  ? Icons
                                                                      .lock_open
                                                                  : Icons.lock,
                                                              color: pdfList
                                                                          ?.dayNo ==
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .black,
                                                              size: 25.h,
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  pdfList?.dayNo ==
                                                                          0
                                                                      ? Get.to(
                                                                          PdfView(
                                                                          pdf: pdfList!
                                                                              .link!,
                                                                        ))
                                                                      : CustomAlertDialog(
                                                                              context)
                                                                          .show(
                                                                          onConfirm:
                                                                              () {
                                                                            // Perform action when OK button is pressed
                                                                          },
                                                                          onCancel:
                                                                              () {
                                                                            // Perform action when Cancel button is pressed
                                                                          },
                                                                        );
                                                                },
                                                                child: Text(
                                                                  '${index + 1}. ${pdfList?.title ?? ''}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.h,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      pdfList?.dayNo == 0
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                Get.to(PdfView(
                                                                  pdf: pdfList!
                                                                      .link!,
                                                                ));
                                                              },
                                                              child: Icon(
                                                                pdfList?.dayNo ==
                                                                        0
                                                                    ? Icons
                                                                        .picture_as_pdf
                                                                    : null,
                                                                color: Colors
                                                                    .green,
                                                                size: 25.h,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                if (controller
                                    .courseDetails.value!.tests!.isNotEmpty)
                                  Divider(
                                    thickness: 1.5.h,
                                  ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                controller
                                        .courseDetails.value!.tests!.isNotEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tests',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.h,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          ListView.builder(
                                            itemCount: controller.courseDetails
                                                .value?.tests?.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final testList = controller
                                                  .courseDetails
                                                  .value
                                                  ?.tests?[index];
                                              // final videos = controller.videoModel.value.videos!;
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              testList?.dayNo ==
                                                                      0
                                                                  ? Icons
                                                                      .lock_open
                                                                  : Icons.lock,
                                                              color: testList
                                                                          ?.dayNo ==
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .black,
                                                              size: 25.h,
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  testList?.dayNo ==
                                                                          0
                                                                      ? Get.to(
                                                                          PdfView(
                                                                          pdf: testList!
                                                                              .link!,
                                                                        ))
                                                                      : CustomAlertDialog(
                                                                              context)
                                                                          .show(
                                                                          onConfirm:
                                                                              () {
                                                                            // Perform action when OK button is pressed
                                                                          },
                                                                          onCancel:
                                                                              () {
                                                                            // Perform action when Cancel button is pressed
                                                                          },
                                                                        );
                                                                },
                                                                child: Text(
                                                                  '${index + 1}. ${testList?.title ?? ''}',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.h,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      testList?.dayNo == 0
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                Get.to(PdfView(
                                                                  pdf: testList!
                                                                      .link!,
                                                                ));
                                                              },
                                                              child: Icon(
                                                                testList?.dayNo ==
                                                                        0
                                                                    ? Icons
                                                                        .picture_as_pdf
                                                                    : null,
                                                                color: Colors
                                                                    .green,
                                                                size: 25.h,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),

                        SizedBox(
                          height: 10.h,
                        ),

                        Divider(
                          thickness: 1.5.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // // Comments
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reviews",
                              style: TextStyle(
                                  fontSize: 16.h, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Click view all comments');
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //
                        controller.courseDetails.value!.reviews!.isEmpty
                            ? Center(
                                child: Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: Text('No Review Found'),
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: controller
                                    .courseDetails.value!.reviews!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                      bottom: 10.h,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Rating(
                                                    rating: controller
                                                            .courseDetails
                                                            .value
                                                            ?.reviews?[index]
                                                            .rating
                                                            ?.toDouble() ??
                                                        0,
                                                  ),
                                                  Text(controller
                                                          .courseDetails
                                                          .value
                                                          ?.reviews?[index]
                                                          .createdAt
                                                          .toString() ??
                                                      "")
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                controller
                                                        .courseDetails
                                                        .value
                                                        ?.reviews?[index]
                                                        .userName ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 14.h,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                controller
                                                        .courseDetails
                                                        .value
                                                        ?.reviews?[index]
                                                        .comment ??
                                                    '',
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.isCourseDetailsLoading.value
            ? BottomNavigationBarShimmer()
            : Container(
                height: 60,
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        loading: false,
                        onPress: () {},
                        text: 'Add to cart',
                      ),
                    ),
                    Expanded(
                      child: RoundedButton(
                        isLoading: false,
                        text: 'Buy Now',
                        onPress: () {},
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildIndicator() => Obx(
        () => AnimatedSmoothIndicator(
          activeIndex: Get.find<CoursesController>().currentIndex.value,
          count:
              Get.find<CoursesController>().courseDetails.value!.images!.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 10,
            dotColor: Colors.teal.shade100,
            activeDotColor: Colors.tealAccent.shade700,
          ),
        ),
      );
}
