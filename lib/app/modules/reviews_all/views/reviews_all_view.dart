import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import '../../../widgets/reviews.dart';
import '../../../widgets/text.dart';
import '../controllers/reviews_all_controller.dart';

class ReviewsAllView extends GetView<ReviewsAllController> {
  const ReviewsAllView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "Reviews"),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Reviews(
                  name: "Tushar",
                  comment: "Nice",
                  rating: 4,
                ),
                Reviews(
                  name: "Sakshi",
                  comment: "Good",
                  rating: 3,
                ),
                Reviews(
                  name: "Tushar",
                  comment: "Nice",
                  rating: 4,
                ),
                Reviews(
                  name: "Sakshi",
                  comment: "Good",
                  rating: 3,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            right: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(20),
                height: 55,
                decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: BigText(
                    text: "ADD REVIEW",
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
