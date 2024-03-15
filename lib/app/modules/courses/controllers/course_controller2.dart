import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/base_client.dart';
import '../../../model/course/course_detail_model2.dart';
import '../../../model/course/video_model2.dart';
import '../../../utils/globals.dart';
import 'package:http/http.dart' as http;

class CourseController2 extends GetxController {

  final courseDetails = Rx<CourseDetailsModel2?>(null);

  RxBool isCourseDetailsLoading = false.obs;
  RxBool isLoading = false.obs;

  setCourseDetails2(CourseDetailsModel2 courseDetailsModel){
    courseDetails.value = courseDetailsModel;
  }

  //
  // Future<void> getCourseDetails(int id) async {
  //   isCourseDetailsLoading.value = true;
  //   try {
  //     final response = await ApiBaseClient().getCourseDetails(id);
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       if (jsonData != null) {
  //         final details = CourseDetailsModel2.fromJson(jsonData);
  //         setCourseDetails2(details);
  //         print("========== Course Details ===========");
  //         print(response.body);
  //         isCourseDetailsLoading.value = false;
  //       } else {
  //         print('API response is null or empty.');
  //         isCourseDetailsLoading.value = false;
  //       }
  //     } else {
  //       print('Failed to fetch product details. Status Code: ${response.statusCode}');
  //       isCourseDetailsLoading.value = false;
  //     }
  //   } catch (e) {
  //     print('My Error here: $e');
  //     isCourseDetailsLoading.value = false;
  //   }
  // }

  Future<void> fetchCourseDetails(int id) async {
    isCourseDetailsLoading.value = true;
    try {
      final response = await ApiBaseClient().getCourseDetails(id);
      // final baseUrl = UtilGlobals.baseUrl;
      // final uri = Uri.parse('$baseUrl/user-show-courses-detail.php?id=$id');
      // final prefs = await SharedPreferences.getInstance();
      // final token = prefs.getString('token');
      // var headers = {
      //   'token': '$token',
      // };
      // final response = await http.get(
      //   uri,
      //   headers: headers,
      // );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        final courseDetailsModel = CourseDetailsModel2.fromJson(data);
        // courseDetails.value = courseDetailsModel;
        setCourseDetails2(courseDetailsModel);
        isCourseDetailsLoading.value = false;
        return data;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        isCourseDetailsLoading.value = false;
        return null;
      }
    } catch (e) {
      isCourseDetailsLoading.value = false;
      print('Error fetching data: $e');
      return null;
    }
  }

  final videoList = [].obs;

  getVideo(int id) async {
    isLoading.value = true;
    try {
      final response = await ApiBaseClient().getCourseDetails(id);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final orderModel = VideoModel2.fromJson(jsonResponse); // Parse the JSON using CartModel
        if (orderModel.videos != null) {
          videoList.clear(); // Clear the previous list
          videoList.addAll(orderModel.videos!); // Add the parsed cart items to the list
          isLoading.value = false;
          print("Cart Items:");
          videoList.forEach((orderItem) {
            print("Order Status: ${orderItem.status}");
          });
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }


}