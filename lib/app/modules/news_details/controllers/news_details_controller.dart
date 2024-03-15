import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/model/news/news_details.dart';

import '../../../api/base_client.dart';
import '../../../utils/globals.dart';
import 'package:http/http.dart' as http;

class NewsDetailsController extends GetxController{

  final isLoading = false.obs;
  final newsDetails = Rx<NewsDetailsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // fetchNewsDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setProductDetails(NewsDetailsModel newsDetailsModel){
    newsDetails.value = newsDetailsModel;
  }

  getNewsDetails() async {
    isLoading.value = true;
    try {
      final response = await ApiBaseClient().getNewsDetails(12);
      print('Response code is ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // final details = NewsDetailsModel.fromJson(jsonData);
        // newsDetails.value = details; // Set the value using the .value property
        print("========== News Details ===========");
        print(response.body);
        // print(jsonData['id']);
        isLoading.value = false;
      } else {
        print(response.statusCode.toString());
        isLoading.value = false;
      }
    } catch (e) {
      print('My Error here is: $e');
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> fetchNewsDetails(int id) async {
    final baseUrl = UtilGlobals.baseUrl;
    final uri = Uri.parse('$baseUrl/user-show-news-detail.php?id=$id');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var headers = {
        'token': '$token',
      };

      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final newsModel = NewsDetailsModel.fromJson(data);
        newsDetails.value = newsModel;
        return data;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  void showData(int id) async {
    final data = await fetchNewsDetails(id);
    if (data != null) {
      final newsModel = NewsDetailsModel.fromJson(data);
      newsDetails.value = newsModel;
    }
  }

}