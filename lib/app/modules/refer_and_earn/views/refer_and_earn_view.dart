import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/widgets/app_color.dart';

import '../../../data/app_image.dart';
import '../../../widgets/text.dart';
import '../controllers/refer_and_earn_controller.dart';

class ReferAndEarnView extends GetView<ReferAndEarnController> {
  const ReferAndEarnView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "Refer & Earn"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImage.refer)))),
                      const SizedBox(
                        height: 10,
                      ),
                      SmallText(
                        text: "Referral Code",
                        color: Colors.grey.withOpacity(0.8),
                        size: 14,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Tushar23",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SmallText(
                        text: "You Will Get 1000 Points For The Referral",
                        color: Colors.black54,
                        size: 14,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 80,
                        child: Divider(
                          thickness: 3,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    BigText(
                      text: "Refer & Earn",
                      size: 14,
                    ),
                    SizedBox(
                      width: 50,
                      child: Divider(
                        thickness: 3,
                        color: AppColor.mainColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SmallText(text: "This is content for Refer and Earn")
                  ],
                )
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
                    text: "SHARE",
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
