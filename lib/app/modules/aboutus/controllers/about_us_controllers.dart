import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssgc/app/api/base_client.dart';

class AboutUsController extends GetxController{

  final aboutUs = "".obs;
  final terms = "".obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAboutUseAndTerms();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAboutUseAndTerms() async {
    try {
      isLoading.value = true;
      final response = await ApiBaseClient().getAboutUsAndTerms();
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        print("Get data");
        print("//////////////////////////////////////");
        print(responseData['about']);
        aboutUs.value = responseData['about'];
        terms.value = responseData['terms'];
        print("//////////////////////////////////////");
      }
      else {
        print(response.statusCode.toString());
        isLoading.value = false;
      }
    }catch(e){
      isLoading.value = false;
      print("Error is ------> ${e.toString()}");
    }
  }
}