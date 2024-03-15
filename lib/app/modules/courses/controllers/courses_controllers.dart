import 'dart:convert';

import 'package:get/get.dart';
import 'package:ssgc/app/api/base_client.dart';
import 'package:ssgc/app/model/category.dart';
import 'package:ssgc/app/model/course/category_wise_course.dart';
import 'package:ssgc/app/model/course/course_details.dart';
import 'package:ssgc/app/model/course/new_release.dart';

import '../../../model/course/course_detail_model2.dart';
import '../../../model/course/video_model.dart';
import 'package:video_player/video_player.dart';

class CoursesController extends GetxController{

  final categories = [].obs;
  final newReleaseList = [].obs;
  final englishNewReleaseList = [].obs;
  RxBool isCategoryLoading = true.obs;
  RxBool isNewReleaseLoading = true.obs;
  RxBool isEnglishNewReleaseLoading = true.obs;
  RxBool isCategoryWiseCourseLoading = true.obs;

  RxBool isViewAllCategoryWiseCourseLoading = true.obs;
  RxBool isFilterEnglishCourses = true.obs;
  RxBool isFilterHindiCourses = true.obs;

  RxBool isCourseDetailsLoading = true.obs;
  final RxInt selectedIndex = RxInt(-1);
  final isSelected = false.obs;
  final selectedName = ''.obs;
  final selectedId = 0.obs;

  final Map<int, RxList<CategoryWiseCourseModel>> categoryWiseCourses = {};
  final categoryWiseCourseList = [].obs;
  final viewAllCategoryWiseCourseList = [].obs;


  final filterHindiCourses = [].obs;
  final filterEnglishCourses = [].obs;

  final courseDetails = Rx<CourseDetailsModel2?>(null);

  var currentIndex = 0.obs;
  var selectedItem = 0.obs;

  var videoModel = VideoModel().obs;
  var allDays = <List<Day>>[].obs;

  late VideoPlayerController videoController;
  final isVideoLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void selectItem(int index) {
    selectedItem.value = index;
  }

  refreshItem() {

  }

  getCategories(String type) async {
    print("Calling get categories");
    isCategoryLoading.value = true;
    try {
      print("Calling get categories in try block");
      final response = await ApiBaseClient().getTypeWiseCategory(type);
      if (response.statusCode == 200) {
        print("Response Success");
        var categoryList = [];
        categoryList = jsonDecode(response.body);
        categories.clear();
        for (var element in categoryList) {
          categories.add(CategoryModel.fromJson(element));
          final categoryId = element['id']; // Adjust this to access the category ID from your data
          categoryWiseCourses[categoryId] = <CategoryWiseCourseModel>[].obs;
        }
        // print(categoryList);
        isCategoryLoading.value = false;
        update();
      } else {
        // isCategoryLoadingError.value = true;
        print("Status Code =====> ${response.statusCode}");
        isCategoryLoading.value = false;
        update();
      }
    }catch(e){
      print("Error =============> "+e.toString());
      isCategoryLoading.value = false;
      update();
    }
  }

  getCategoryWiseCourse(int categoryId, String language, String type) async {
    isCategoryWiseCourseLoading.value = true;
    print("Printing here");
    final response = await ApiBaseClient().getCategoryWiseCourse(categoryId, language, type);
    if (response.statusCode == 200) {
      var newsList = [];
      newsList = jsonDecode(response.body);
      final categoryList = categoryWiseCourses[categoryId];
      categoryList?.clear();

      for (var element in newsList) {
        categoryWiseCourseList.clear();
        categoryWiseCourseList.add(CategoryWiseCourseModel.fromJson(element));
        categoryList?.add(CategoryWiseCourseModel.fromJson(element));
      }
      print("============Category wise data================");
      print(categoryWiseCourseList);
      print("============================");
      isCategoryWiseCourseLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isCategoryWiseCourseLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  void selectCategory(int index) {
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
  
  getNewRelease(String language, String type) async {
    isNewReleaseLoading.value = true;
    try {
      final response = await ApiBaseClient().getNewReleaseByType(language, 'all', type);
      if (response.statusCode == 200){
        var newRelease = [];
        newRelease = jsonDecode(response.body);
        newReleaseList.clear();
        for (var element in newRelease){
          newReleaseList.add(NewReleaseModel.fromJson(element));
        }
        isNewReleaseLoading.value = false;
        print(newReleaseList);
        update();
      }
    }catch (e){
      isNewReleaseLoading.value = false;
      update();
    }
  }

  getEnglishNewRelease(String type) async {
    isEnglishNewReleaseLoading.value = true;
    try {
      final response = await ApiBaseClient().getNewReleaseByType('en', 'all', type);
      if (response.statusCode == 200){
        var newRelease = [];
        newRelease = jsonDecode(response.body);
        englishNewReleaseList.clear();
        for (var element in newRelease){
          englishNewReleaseList.add(NewReleaseModel.fromJson(element));
        }
        isEnglishNewReleaseLoading.value = false;
        print(englishNewReleaseList);
        update();
      }
    }catch (e){
      isEnglishNewReleaseLoading.value = false;
      update();
    }
  }

  setCourseDetails(CourseDetailsModel2 courseDetailsModel){
    courseDetails.value = courseDetailsModel;
  }

  getCourseDetails(int id) async {
    isCourseDetailsLoading.value = true;
    try {
      print(("Id is $id"));
      final response = await ApiBaseClient().getCourseDetails(id);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final details = CourseDetailsModel2.fromJson(jsonData);
        setCourseDetails(details);
        print("========== Course Details ===========");
        print(response.body);
        isCourseDetailsLoading.value = false;
      } else {
        print(response.statusCode.toString());
        print('Failed to fetch product details');
        isCourseDetailsLoading.value = false;
      }
    } catch (e) {
      print('My Error here: $e');
      isCourseDetailsLoading.value = false;
    }
  }

  getCourseVideo(int id) async {
    isVideoLoading.value = true;
    try {
      isVideoLoading.value = true;
      final response = await ApiBaseClient().getCourseDetails(id);
      if (response.statusCode == 200){
        final Map<String, dynamic> data = json.decode(response.body);
        final videoData = VideoModel.fromJson(data);
        videoModel.value = videoData;
        print("-------------------------------------------");
        print("My data is ${videoModel.value.videos}");
        print("-------------------------------------------");

        // Dynamically collect all non-null day lists into allDays list
        allDays.clear();
        for (var i = 0; i < videoModel.value.videos!.toJson().length; i++) {
          final dayList = videoModel.value.videos!.toJson()['day$i'];
          if (dayList != null) {
            allDays.add(List<Day>.from(dayList.map((x) => Day.fromJson(x))));
          }
        }

        isVideoLoading.value = false;

      } else {
        print("Status Code is ${response.statusCode}");
        isVideoLoading.value = false;
      }
    } catch (e){
      print('My Exception is ${e.toString()}');
      isVideoLoading.value = false;
    }
  }

  viewAllCoursesByCategory(int id, String language, String type) async {
    isViewAllCategoryWiseCourseLoading.value = true;
    print("Printing here");
    final response = await ApiBaseClient().getCategoryWiseCourse(id, language, type);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      viewAllCategoryWiseCourseList.clear();

      for (var element in allCourseList) {
        viewAllCategoryWiseCourseList.add(CategoryWiseCourseModel.fromJson(element));
      }
      print("============Category wise data================");
      print(viewAllCategoryWiseCourseList);
      print("============================");
      isViewAllCategoryWiseCourseLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isViewAllCategoryWiseCourseLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  filterHindiCourse(int id, String language, String type) async {
    isViewAllCategoryWiseCourseLoading.value = true;
    print("Printing here");
    final response = await ApiBaseClient().getCategoryWiseCourse(id, language, type);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterHindiCourses.clear();

      for (var element in allCourseList) {
        filterHindiCourses.add(CategoryWiseCourseModel.fromJson(element));
      }
      print("============Category wise data================");
      print(filterHindiCourses);
      print("============================");
      isViewAllCategoryWiseCourseLoading.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isViewAllCategoryWiseCourseLoading.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }

  filterEnglishCourse(int id, String language, String type) async {
    isFilterEnglishCourses.value = true;
    print("Printing here");
    final response = await ApiBaseClient().getCategoryWiseCourse(id, language, type);
    if (response.statusCode == 200) {
      var allCourseList = [];
      allCourseList = jsonDecode(response.body);
      filterEnglishCourses.clear();

      for (var element in allCourseList) {
        filterEnglishCourses.add(CategoryWiseCourseModel.fromJson(element));
      }
      print("============Category wise data================");
      print(filterEnglishCourses);
      print("============================");
      isFilterEnglishCourses.value = false;
    } else {
      // isBannerLoadingError.value = true;
      isFilterEnglishCourses.value = false;
      update();
      print("==================Error===============");
      print(response.statusCode);
    }
  }


  void initializeVideoController(String videoUrl) {
    videoController = VideoPlayerController.network(videoUrl);
    videoController.initialize().then((_) => update());
  }


  @override
  void onClose() {
    super.onClose();
    videoController.dispose();
    selectedItem.close();
  }
}