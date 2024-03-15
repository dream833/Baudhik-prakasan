import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssgc/app/model/user_category_wise_book.dart';

import '../../../api/base_client.dart';
import '../../../model/book_home.dart';
import '../../../model/category.dart';
import '../../../model/new_release.dart';

class DetailPageController extends GetxController {
  //TODO: Implement DetailPageController

  final isBookLoading = false.obs;
  final isBookCategoryLoading = false.obs;
  var isCategoryLoadingError = false.obs;
  final isCategoryLoading = false.obs;

  final isCategoryWiseBookLoading = false.obs;
  final isFilterHindiBookLoading = false.obs;
  final isFilterEnglishBookLoading = false.obs;

  final isHindiNewReleaseLoading = false.obs;
  final isEnglishNewReleaseLoading = false.obs;


  final isNewReleaseLoading = false.obs;

  final RxInt selectedTabIndex = (0).obs;

  final categories = [].obs;

  final categoryWiseBookList = [].obs;
  final filterHindiBookList = [].obs;
  final filterEnglishBookList = [].obs;

  final newReleaseHindiBook = [].obs;
  final newReleaseEnglishBook = [].obs;

  final homeBooks = [].obs;
  final userCategoryWiseBooks = [].obs;
  final newRelease = [].obs;
  final Map<int, RxList<UserCategoryWiseBook>> categoryWiseBooks = {};

  final RxInt selectedIndex = RxInt(-1);
  final selectedCategoryName = "".obs;
  final RxInt selectedCategoryId = 0.obs;

  final isSelected = false.obs;
  final selectedText = ''.obs;
  final filter = "all".obs;
  final language = "in".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
    getHomeBook();
    // getNewRelease();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void selectItem(int index) {
    selectedIndex.value = index;
    update();
  }

  void selectCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
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


  getCategories() async {
    isCategoryLoading.value = true;
    try {
      final response = await ApiBaseClient().getCategories();
      if (response.statusCode == 200) {
        var categoryList = [];
        categoryList = jsonDecode(response.body);
        for (var element in categoryList) {
          categories.add(CategoryModel.fromJson(element));
          final categoryId = element['id']; // Adjust this to access the category ID from your data
          categoryWiseBooks[categoryId] = <UserCategoryWiseBook>[].obs;
        }
        isCategoryLoading.value = false;
        update();
      } else {
        isCategoryLoadingError.value = true;
        isCategoryLoading.value = false;
        update();
      }
    }catch(e){
      print(e.toString());
      isCategoryLoading.value = false;
      update();
    }
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  getHomeBook() async {
    isBookLoading.value = true;
    final response = await ApiBaseClient().getHomeBook('in');
    if (response.statusCode == 200) {
      var bookList = [];
      bookList = jsonDecode(response.body);
      // setPageCount(bannerList.length);
      for (var element in bookList) {
        homeBooks.add(BookHome.fromJson(element));
      }
      isBookLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isBookLoading.value = false;
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  getUserAllBookByCategory(int id, String language, String type) async {
    isBookCategoryLoading.value = true;
    final response = await ApiBaseClient().getUserAllBookByCategory(id, language, type);
    if (response.statusCode == 200) {
      var bookList = [];
      bookList = jsonDecode(response.body);
      final categoryList = categoryWiseBooks[id];
      categoryList?.clear();
      for (var element in bookList) {
        userCategoryWiseBooks.add(UserCategoryWiseBook.fromJson(element));
        categoryList?.add(UserCategoryWiseBook.fromJson(element));
      }
      isBookCategoryLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isBookCategoryLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  getNewRelease(String type, String language) async {
    try {
      isNewReleaseLoading.value = true;
      final response = await ApiBaseClient().getNewRelease(language, 'all', type);
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        print("============New release=============");
        print(response.body);
        newRelease.clear();
        // setPageCount(bannerList.length);
        for (var element in newReleaseList) {
          newRelease.add(NewRelease.fromJson(element));
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
      final response = await ApiBaseClient().getNewRelease('in', 'all', type);
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        print("============News New release=============");
        print(response.body);
        newReleaseHindiBook.clear();
        // setPageCount(bannerList.length);
        for (var element in newReleaseList) {
          newReleaseHindiBook.add(NewRelease.fromJson(element));
        }
        print('////////////////////Hindi new release/////////////////////////////');
        print(newReleaseList);
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
      final response = await ApiBaseClient().getNewRelease('en', 'all', type);
      if (response.statusCode == 200) {
        var newReleaseList = [];
        newReleaseList = jsonDecode(response.body);
        print("============News New release=============");
        print(response.body);
        newReleaseEnglishBook.clear();
        // setPageCount(bannerList.length);
        for (var element in newReleaseList) {
          newReleaseEnglishBook.add(NewRelease.fromJson(element));
        }
        print('////////////////////English new release/////////////////////////////');
        print(newReleaseList);
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

  fetchCategoryWiseBook(int categoryId, String language, String type) async {
    isCategoryWiseBookLoading.value = true;
    final response = await ApiBaseClient().fetchCategoryWiseBook(categoryId, language, type);
    if (response.statusCode == 200) {
      var bookList = [];
      bookList = jsonDecode(response.body);
      categoryWiseBookList.clear();
      // setPageCount(bannerList.length);
      for (var element in bookList) {
        categoryWiseBookList.add(UserCategoryWiseBook.fromJson(element));
      }
      isCategoryWiseBookLoading.value = false;
      update();
    } else {
      // isBannerLoadingError.value = true;
      isCategoryWiseBookLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  filterHindiBook(int id, String language, String type) async {
    isFilterHindiBookLoading.value = true;
    print("Printing here");
    final response = await ApiBaseClient().fetchCategoryWiseBook(id, language, type);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterHindiBookList.clear();

      for (var element in allCourseList) {
        filterHindiBookList.add(UserCategoryWiseBook.fromJson(element));
      }
      print("============Category wise data================");
      print(filterHindiBookList);
      print("============================");
      isFilterHindiBookLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isFilterHindiBookLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  filterEnglishBook(int id, String language, String type) async {
    isFilterEnglishBookLoading.value = true;
    print("Printing here");
    final response = await ApiBaseClient().fetchCategoryWiseBook(id, language, type);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterEnglishBookList.clear();

      for (var element in allCourseList) {
        filterEnglishBookList.add(UserCategoryWiseBook.fromJson(element));
      }
      print("============Category wise data================");
      print(filterEnglishBookList);
      print("============================");
      isFilterEnglishBookLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isFilterEnglishBookLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

}
