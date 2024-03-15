import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/widgets/empty_widget.dart';

import '../../../widgets/app_color.dart';
import '../../../widgets/text.dart';
import '../controllers/purchase_controller.dart';

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white50,
          title: BigText(text: "My Purchase"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppColor.mainColor,
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "New",
              ),
              Tab(
                text: "National",
              ),
              Tab(
                text: "International",
              ),
              Tab(
                text: "Science",
              ),
              Tab(
                text: "Economics",
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TabBarView(
            children: [
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
              EmptyView(
                  image: AssetImage(AppImage.search),
                  mainText: "No Purchase Yet!!",
                  subText: "We Couldn't fint what you are looking for."),
            ],
          ),
        ),
      ),
    );
  }
}
