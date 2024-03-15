import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ssgc/app/api/base_client.dart';
import 'package:ssgc/app/model/category.dart';

import '../../../model/quize/quize.dart';

class QuizController extends GetxController {

  final isQuizLoading = false.obs;
  final isCategoryLoading = false.obs;
  final quiz = QuizModel().obs;

  final categoryList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategories();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  setQuizDetails(QuizModel value){
    quiz.value = value;
  }

  getCategories() async {
    isCategoryLoading.value = true;
    final response = await ApiBaseClient().getTypeWiseCategory('quiz');
    if (response.statusCode == 200){
      debugPrint('///////////////////Categories///////////////////');
      debugPrint(response.body);
      // categoryList.clear();
      // categoryList.add(CategoryModel.fromJson(json));

      var categories = [];
      categories = jsonDecode(response.body);
      categoryList.clear();
      for (var element in categories) {
        categoryList.add(CategoryModel.fromJson(element));
        // final categoryId = element['id']; // Adjust this to access the category ID from your data
        // categoryWiseCourses[categoryId] = <CategoryWiseCourseModel>[].obs;
      }
      isCategoryLoading.value = false;
    }
  }


  getQuiz() async {
    try {
      isQuizLoading.value = true;
      final response = await ApiBaseClient().getQuiz(2);
      if (response.statusCode == 200){
        debugPrint('/////////////////////////////////////');
        debugPrint(response.body);
        final jsonData = json.decode(response.body);
        final details = QuizModel.fromJson(jsonData);
        setQuizDetails(details);
        isQuizLoading.value = false;
      }
      else {
        debugPrint('Status code : ${response.statusCode}');
        isQuizLoading.value = false;
      }
    } catch (e){
      isQuizLoading.value = false;
      debugPrint('Exception is ${e.toString()}');
    }
  }





  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}