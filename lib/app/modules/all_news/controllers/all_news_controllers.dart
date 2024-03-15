import 'dart:convert';

import 'package:get/get.dart';

import '../../../api/base_client.dart';
import '../../../model/category.dart';
import '../../../model/news/news_by_category.dart';
import '../../../model/news/news_new_release.dart';

class AllNewsControllers extends GetxController{

  final isCategoryLoading = false.obs;

  final isNewReleaseLoading = false.obs;
  final isHindiNewReleaseLoading = false.obs;
  final isEnglishNewReleaseLoading = false.obs;

  final isCategoryWiseNewsLoading = false.obs;
  final isViewAllCategoryWiseNewsLoading = false.obs;

  final isFilterEnglishNews = false.obs;
  final isFilterHindiNews = false.obs;

  final categories = [].obs;

  final newReleaseNews = [].obs;
  final newReleaseHindiNews = [].obs;
  final newReleaseEnglishNews = [].obs;

  final Map<int, RxList<NewsByCategoryModel>> categoryWiseNews = {};
  final userCategoryWiseNews = [].obs;
  final viewAllCategoryWiseNewsList = [].obs;

  final selectedCategoryId = 0.obs;
  final selectedCategoryName = "".obs;
  final RxInt selectedIndex = RxInt(-1);
  final isSelected = false.obs;

  final filterEnglishNewsList = [].obs;
  final filterHindiNewsList = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleItem(int index) {
    if (selectedIndex.value == index) {
      // If the tapped item is already selected, deselect it
      selectedIndex.value = -1;
      isSelected.value = false;
      update();
    } else {
      // Otherwise, select the tapped item
      selectedIndex.value = index;
      isSelected.value = true;
      update();
    }
    update();
  }


  getNewRelease(String type, String language) async {
    try {
      isNewReleaseLoading.value = true;
      final response = await ApiBaseClient().getNewReleaseNews(language, 'all');
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        newReleaseNews.clear();
        for (var element in newReleaseList) {
          newReleaseNews.add(NewsNewReleaseModel.fromJson(element));
        }
        isNewReleaseLoading.value = false;
        update();
      } else {
        isNewReleaseLoading.value = false;
        update();
      }
    } catch(e){
      isNewReleaseLoading.value = false;
      update();
      print("Exception is ${e.toString()}");
    }
  }

  getHindiNewRelease(String type) async {
    try {
      isHindiNewReleaseLoading.value = true;
      final response = await ApiBaseClient().getNewReleaseNews('in', 'all');
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        newReleaseHindiNews.clear();
        for (var element in newReleaseList) {
          newReleaseHindiNews.add(NewsNewReleaseModel.fromJson(element));
        }
        isHindiNewReleaseLoading.value = false;
        update();
      } else {
        isHindiNewReleaseLoading.value = false;
        update();
      }
    } catch(e){
      isHindiNewReleaseLoading.value = false;
      update();
      print("Exception is ${e.toString()}");
    }
  }

  getEnglishNewRelease(String type) async {
    try {
      isEnglishNewReleaseLoading.value = true;
      final response = await ApiBaseClient().getNewReleaseNews('en', 'all');
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        newReleaseEnglishNews.clear();
        // setPageCount(bannerList.length);
        for (var element in newReleaseList) {
          newReleaseEnglishNews.add(NewsNewReleaseModel.fromJson(element));
        }
        isEnglishNewReleaseLoading.value = false;
        update();
      } else {
        isEnglishNewReleaseLoading.value = false;
        update();
      }
    } catch(e){
      isEnglishNewReleaseLoading.value = false;
      update();
      print("Exception is ${e.toString()}");
    }
  }

  getCategories(String type) async {
    isCategoryLoading.value = true;
    try {
      final response = await ApiBaseClient().getCategoriesByType(type);
      if (response.statusCode == 200) {
        var categoryList = [];
        categoryList = jsonDecode(response.body);
        categories.clear();
        for (var element in categoryList) {
          categories.add(CategoryModel.fromJson(element));
          final categoryId = element['id'];
          categoryWiseNews[categoryId] = <NewsByCategoryModel>[].obs;
        }
        isCategoryLoading.value = false;
      } else {
        // isCategoryLoadingError.value = true;
        isCategoryLoading.value = false;
      }
    }catch(e){
      print(e.toString());
    }
  }

  getCategoryWiseNews(int categoryId, String language) async {
    isCategoryWiseNewsLoading.value = true;
    final response = await ApiBaseClient().getCategoryWiseNews(categoryId, language);
    if (response.statusCode == 200) {
      var newsList = [];
      newsList = jsonDecode(response.body);
      final categoryList = categoryWiseNews[categoryId];
      categoryList?.clear();
      for (var element in newsList) {
        userCategoryWiseNews.add(NewsByCategoryModel.fromJson(element));
        categoryList?.add(NewsByCategoryModel.fromJson(element));
      }
      isCategoryWiseNewsLoading.value = false;
    } else {
      isCategoryWiseNewsLoading.value = false;
      update();
    }
  }

  filterEnglishNews(int id, String language) async {
    isFilterEnglishNews.value = true;
    final response = await ApiBaseClient().getCategoryWiseNews(id, language);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterEnglishNewsList.clear();

      for (var element in allCourseList) {
        filterEnglishNewsList.add(NewsByCategoryModel.fromJson(element));
      }
      isFilterEnglishNews.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isFilterEnglishNews.value = false;
      update();
    }
  }

  filterHindiNews(int id, String language) async {
    isFilterHindiNews.value = true;
    final response = await ApiBaseClient().getCategoryWiseNews(id, language);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterHindiNewsList.clear();

      for (var element in allCourseList) {
        filterHindiNewsList.add(NewsByCategoryModel.fromJson(element));
      }
      isFilterHindiNews.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isFilterHindiNews.value = false;
      update();
    }
  }

  viewAllNewsByCategory(int id, String language) async {
    isViewAllCategoryWiseNewsLoading.value = true;
    final response = await ApiBaseClient().getCategoryWiseNews(id, language);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      viewAllCategoryWiseNewsList.clear();

      for (var element in allCourseList) {
        viewAllCategoryWiseNewsList.add(NewsByCategoryModel.fromJson(element));
      }
      isViewAllCategoryWiseNewsLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isViewAllCategoryWiseNewsLoading.value = false;
      update();
    }
  }

}