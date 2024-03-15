import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/api/base_client.dart';

import '../../../model/banner.dart';
import '../../../model/category.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController



  final banners = [].obs;
  var isBannerLoadingError = false.obs;
  final isBannerLoading = false.obs;
  final count = 0.obs;
  Timer? _timer;

  void increment() => count.value++;

  var controller = PageController();
  final pageCount = 0.obs;

  // List<String> yourImageList = [
  //   'assets/image1.jpg',
  //   'assets/image2.jpg',
  //   'assets/image3.jpg',
  // ];
  @override
  void onInit() {
    super.onInit();
    getBanners();
    startAutoScroll();
  }

  @override
  void onClose() {
    stopAutoScroll();
    super.onClose();
  }



  getBanners() async {
    isBannerLoading.value = true;
    final response = await ApiBaseClient().getBanners();
    if (response.statusCode == 200) {
      var bannerList = [];
      bannerList = jsonDecode(response.body);
      setPageCount(bannerList.length);
      for (var element in bannerList) {
        banners.add(BannerModel.fromJson(element));
      }
      isBannerLoading.value = false;
    } else {
      isBannerLoadingError.value = true;
      isBannerLoading.value = false;
    }
  }

  setPageCount(int pageLength) {
    pageCount.value = pageLength;
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final int currentPage = controller.page!.toInt();
      final int totalPages = pageCount.value;
      if (currentPage == totalPages - 1) {
        controller.jumpToPage(0);
      } else {
        controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  void stopAutoScroll() {
    _timer?.cancel();
  }
}
