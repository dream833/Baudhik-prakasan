import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/account/views/account_view.dart';
import 'package:ssgc/app/modules/cart/views/cart_view.dart';
import 'package:ssgc/app/modules/profile/controllers/profile_controller.dart';
import 'package:ssgc/app/modules/purchase/views/purchase_view.dart';

import '../../../widgets/app_color.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends GetView<BottomNavigationBarController> {
  BottomNavigationBarView({Key? key}) : super(key: key);
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.8),
      fontWeight: FontWeight.w400,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12);
  buildBottomNavigationMenu(context, bcontroller) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 2, left: 12, right: 12),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 3,
                    offset: Offset(1, 1),
                ),
              ],
              color: AppColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          // height: 65.sp,
          child: BottomNavigationBar(
            elevation: 0,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: bcontroller.changeTabIndex,
            currentIndex: bcontroller.tabIndex.value,
            backgroundColor: AppColor.white,
            unselectedItemColor: AppColor.black.withOpacity(0.4),
            selectedItemColor: AppColor.mainColor,
            iconSize: 25,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_rounded),
                label: 'Home',
                backgroundColor: AppColor.white,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_rounded),
                label: 'Purchase',
                backgroundColor: AppColor.white,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_bag_rounded),
                label: 'Cart',
                backgroundColor: AppColor.white,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu),
                label: 'Menu',
                backgroundColor: AppColor.white,
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    profileController.getUserData();
    var controller = Get.put<BottomNavigationBarController>(
        BottomNavigationBarController(),
        permanent: false);
    return WillPopScope(
      onWillPop: () => showExitPopup(context, controller),
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomeView(),
              const PurchaseView(),
              CartView(),
              const AccountView(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context, controller) async {
     return controller.tabIndex.value != 0 ?
     controller.tabIndex.value = 0
         : await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.mainColor),
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.buttoncolor,
                        ),
                        child: const Text("No",
                            style: TextStyle(color: Colors.white)),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
