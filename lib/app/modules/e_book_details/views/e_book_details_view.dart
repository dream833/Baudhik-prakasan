import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/reviews_all/views/reviews_all_view.dart';
import 'package:ssgc/app/modules/suggestion_products/views/suggestion_products_view.dart';
import 'package:ssgc/app/widgets/rating.dart';
import 'package:ssgc/app/widgets/reviews.dart';

import '../../../data/app_image.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/text.dart';
import '../controllers/e_book_details_controller.dart';

class EBookDetailsView extends GetView<EBookDetailsController> {
  const EBookDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "E-BooK Details"),
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
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            icon: const Icon(Icons.bookmark_border_outlined),
            color: Colors.black,
            onPressed: () {
              print("BookMarked!!");
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.mainColor,
        onPressed: () {},
        child: Icon(
          Icons.question_answer_rounded,
          color: AppColor.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                height: 250.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImage.demo),
                  ),
                ),
              ),
              // introduction content
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: Get.width / 1.2,
                            child:
                                BigText(text: "World Investment Report, 2023")),
                        Icon(
                          Icons.favorite_border,
                          size: 25,
                          color: Colors.red.shade300,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SmallText(
                      text: "Free ",
                      color: AppColor.mainColor,
                      size: 14,
                    ),
                    // tabs section
                    _tabSection(context),
                    const Divider(
                      thickness: 1.2,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    SmallText(
                      text: "Frequently bought together",
                      size: 16,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(1, 1)),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImage.red_bull))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width / 2,
                                padding: const EdgeInsets.only(top: 10),
                                child: SmallText(
                                  text:
                                      "Current Affairs Pointers, Weekly 17-23 August, 2023",
                                  size: 14,
                                ),
                              ),
                              const Rating(
                                rating: 4,
                              ),
                              SmallText(
                                text: "Free ",
                                color: AppColor.mainColor,
                                size: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SuggestionProductsView(text: "Related Product"),
              const SuggestionProductsView(text: "Recently Viewed"),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: "Comments Reviews",
                    size: 16,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Rating(
                        rating: 4,
                      ),
                      SmallText(text: "4.0 Out of 5")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1.2,
                    color: Colors.black12,
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: "Reviews",
                    size: 16,
                    color: Colors.black87,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ReviewsAllView());
                    },
                    child: SmallText(
                      text: "View All",
                      size: 16,
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Reviews(
                name: "Tushar",
                comment: "Nice",
                rating: 4,
              ),
              const Reviews(
                name: "Sakshi",
                comment: "Good",
                rating: 3,
              ),
              const Reviews(
                name: "Tushar",
                comment: "Nice",
                rating: 4,
              ),
              const Reviews(
                name: "Sakshi",
                comment: "Good",
                rating: 3,
              ),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              height: 55,
              width: Get.width / 2.2,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.mainColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: BigText(
                  text: "ADD TO CART",
                  color: AppColor.mainColor,
                  size: 14,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 55,
              width: Get.width / 2.2,
              decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: BigText(
                  text: "BUY NOW",
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ],
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
        text: TextSpan(children: [
      TextSpan(
          text: '\u2022 $title',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          )),
      TextSpan(
          text: description,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14,
          )),
    ]));
  }
}

Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: TabBar(
              dividerColor: Colors.amber,
              labelColor: AppColor.mainColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColor.mainColor,
              tabs: const [Tab(text: "Features"), Tab(text: "PDF")]),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 20),
          //Add this to give height
          height: Get.height / 5,
          child: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                    text:
                        "With the Prime Minister as the Chairperson, presently NITI Aayog consists of: Vice Chairperson: Suman Bery. Ex-Officio Members: Amit Shah, Rajnath Singh, Nirmala Sitaraman and Narendra Singh Tomar.",
                    color: Colors.grey.shade800),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Sample",
                          size: 13,
                        ),
                        const Icon(
                          Icons.description_outlined,
                          size: 25,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColor.mainColor, width: 2)),
                      child: Center(
                          child: BigText(
                        size: 17,
                        text: "DOWNLOAD E-BOOK",
                        color: AppColor.mainColor,
                      )),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}
