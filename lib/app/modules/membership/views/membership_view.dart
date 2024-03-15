import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/app_image.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/text.dart';
import '../controllers/membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
  const MembershipView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: BigText(text: "Membership"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyView(
                  image: AssetImage(AppImage.wishlist),
                  mainText: "Sorry! NO Result Found : (",
                  subText: "We Couldn't Find What You Are Looking For",
                )
              ],
            )),
      ),
    );
  }
}
