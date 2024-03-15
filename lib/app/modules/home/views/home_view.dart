import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/modules/courses/views/courses_view.dart';
import 'package:ssgc/app/modules/notification/views/notification_view.dart';
import 'package:ssgc/app/modules/quize/view/quiz_view.dart';
import 'package:ssgc/app/modules/search_screen/views/search_screen_view.dart';
import 'package:ssgc/app/modules/video/views/video_view.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/image_loader.dart';

import '../../../widgets/text.dart';
import '../../all_news/views/all_news_view.dart';
import '../../all_news/views/news.dart';
import '../../detail_page/views/detail_page_view.dart';
import '../../product_detail/controllers/product_detail_controller.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());
  // final ProductDetailController productDetailsController = Get.put(ProductDetailController());
  final PageController _pageController = PageController();
  HomeView({Key? key}) : super(key: key);

  List<String> yourImageList = [
    'assets/images/banner.png',
    'assets/images/bannerimage.png',
    'assets/images/book1.png',
  ];
  final List<Map<String, dynamic>> gridData = [
    {
      'name': 'Current News',
      'imagePath': 'assets/images/newspaper.jpg',
    },
    {
      'name': 'Online Quiz',
      'imagePath': 'assets/images/quize.png',
    },
    {
      'name': 'Books',
      'imagePath': 'assets/images/books.jpg',
    },
    {
      'name': 'E-Books',
      'imagePath': 'assets/images/ebook.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        appBar: AppBar(
          toolbarHeight: 55,
          elevation: 2,
          backgroundColor: AppColor.white,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: BigText(
              text: "Baudhik Prakashan Pariksha Vani",
              size: 11.5.w,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => SearchScreenView());
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.r,
                            spreadRadius: 3,
                            offset: Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.r)),
                  child: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(() => const NotificationView());
            //   },
            //   child: Container(
            //       margin: EdgeInsets.symmetric(vertical: 8.0.h),
            //       padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            //       decoration: BoxDecoration(
            //           color: AppColor.mainColor,
            //           boxShadow: [
            //             BoxShadow(
            //                 color: Colors.black12,
            //                 blurRadius: 5.r,
            //                 spreadRadius: 3,
            //                 offset: Offset(1, 1)),
            //           ],
            //           borderRadius: BorderRadius.circular(10.r)),
            //       child: const Icon(
            //         Icons.notifications_active_outlined,
            //         color: Colors.white,
            //       )),
            // ),
            // SizedBox(
            //   width: 20.w,
            // ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() => CustomScrollView(
              slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        controller.isBannerLoading.value
                            ? SizedBox(
                                height: 200,
                                width: 900.w,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : controller.isBannerLoadingError.value
                                ? SizedBox(
                                    height: 200,
                                    width: 900.w,
                                    child: const Center(
                                        child: Text("unable to load banners")),
                                  )
                                : SizedBox(
                                    height: 200,
                                    width: 900.w,
                                    child: PageView.builder(
                                      controller: homeController.controller,
                                      itemCount: controller.banners.length > 5 ? 5 : controller.banners.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {

                                        // return Image(
                                        //   height: 200.h,
                                        //   width: 900.w,
                                        //   image: NetworkImage(
                                        //     controller.banners[index].image.toString(),
                                        //   ),
                                        // );
                                        return AppImageLoader(
                                          imageUrl: controller.banners[index].image,
                                          height: 200.h,
                                          width: 900.w,
                                          loaderColor: Colors.transparent,
                                        );
                                        // return Image.network(
                                        //   controller.banners[index].image,
                                        //   fit: BoxFit.cover,
                                        // );
                                      },
                                      onPageChanged: (int page) {
                                        // setState(() {
                                        //   _currentPage = page;
                                        // });
                                        // controller.setPageCount(
                                        //     controller.banners.length);
                                      },
                                    ),
                                  ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmoothPageIndicator(
                          controller: homeController.controller,
                          count: controller.banners.length > 5 ? 5 : controller.banners.length,
                          effect: ExpandingDotsEffect(
                              activeDotColor: AppColor.mainColor,
                              dotColor: Colors.grey,
                              dotHeight: 8,
                              dotWidth: 8),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // here fetch data from api
                  controller.isBannerLoading.value
                      ? SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.85,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              childCount: 6,
                              (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardDesign(
                                    text: 'Current News',
                                    imageUrl: AppImage.newspaper,
                                    onPress: () {
                                      Get.to(() => NewsView(type: "news"));
                                    },
                                  ),

                                  SizedBox(width: 20.w,),
                                  CardDesign(
                                    text: 'Online Quiz',
                                    imageUrl: AppImage.quize,
                                    onPress: () {
                                      Get.to(() =>  QuizView());
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardDesign(
                                    text: 'Books',
                                    imageUrl: AppImage.book,
                                    onPress: () {
                                      Get.to(() => DetailPageView(type: 'book'));
                                    },
                                  ),

                                  SizedBox(width: 20.w,),
                                  CardDesign(
                                    text: 'E-Books',
                                    imageUrl: AppImage.ebook,
                                    onPress: () {
                                      // Get.to(() =>  DetailPageView(type: "ebook",));
                                      navigateToPetViewPage('ebook', 'E-Book');
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardDesign(
                                    text: 'PET Online Courses',
                                    imageUrl: AppImage.courses,
                                    onPress: () {
                                      navigateToPetViewPage('pet', 'Courses');
                                      // Get.to(() => DetailPageView(type: 'book'));
                                    },
                                  ),

                                  SizedBox(width: 20.w,),
                                  CardDesign(
                                    text: 'Video Lectures',
                                    imageUrl: AppImage.video_lecture,
                                    onPress: () {
                                      navigateToPetViewPage('video', 'Video Lecture');
                                      // Get.to(() =>  DetailPageView(type: "ebook",));
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardDesign(
                                    text: 'Test yourself with PYQ (Previous Year Question)',
                                    imageUrl: AppImage.pyq,
                                    onPress: () {
                                      navigateToPetViewPage('test', 'Courses');
                                      // Get.to(() => DetailPageView(type: 'book'));
                                    },
                                  ),

                                  SizedBox(width: 20.w,),
                                  CardDesign(
                                    text: 'Solved Paper PDF',
                                    imageUrl: AppImage.solved_pdf,
                                    onPress: () {
                                      navigateToPetViewPage('pdf', 'E-Books');
                                      // Get.to(() =>  DetailPageView(type: "ebook",));
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CardDesign(
                                    text: 'Errata',
                                    imageUrl: AppImage.errata,
                                    onPress: () {
                                      // Get.to(() => DetailPageView(type: 'book'));
                                    },
                                  ),

                                  SizedBox(width: 20.w,),
                                  CardDesign(
                                    text: 'Scan and check originality of the Book',
                                    imageUrl: AppImage.scan,
                                    onPress: () {
                                      // Get.to(() =>  DetailPageView(type: "ebook",));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    return SizedBox(
      child: Card(
        // elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            AppImage.banner,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void navigateToPetViewPage(String type, String title) {
    Get.to(() {
      return CoursesView(type: type, title: title,);
    });
    // final cartController = Get.find<CartController>();
    // await cartController.getCart();
  }

  void navigateToVideoViewPage() {
    Get.to(() {
      return VideoView();
    });
    // final cartController = Get.find<CartController>();
    // await cartController.getCart();
  }

  // void navigateToTestViewPage() {
  //   Get.to(() {
  //     return TestView();
  //   });
  //   // final cartController = Get.find<CartController>();
  //   // await cartController.getCart();
  // }
  //
  // void navigateToPDFViewPage() {
  //   Get.to(() {
  //     return PdfView();
  //   });
  //   // final cartController = Get.find<CartController>();
  //   // await cartController.getCart();
  // }

}

class CardDesign extends StatelessWidget {
  final String text;
  final String imageUrl;
  final VoidCallback onPress;
  const CardDesign({super.key, required this.text, required this.imageUrl, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 180.h,
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 14.h, bottom: 14.h,),
        margin: EdgeInsets.only(bottom: 16.h, top: 4.h ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              width: 1.5,
              color: AppColor.mainColor
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 125.w,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Image(
              fit: BoxFit.cover,
              height: 100,
              width: 100,
              image: AssetImage(imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}

