import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/utils/globals.dart';

class ApiBaseClient {
  final client = http.Client();
  // fetch banners
  Future<dynamic> getBanners() async {
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-banner.php');
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  //fetch categories
  Future<dynamic> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-category.php?type=book');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }
  
  Future<dynamic> loginUser(dynamic data) async {
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-login.php');
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await client.post(uri, body: json.encode(data), headers: headers);
    return response;
  }

  // Future<dynamic> userRegistration(dynamic data) async {
  //   final uri = Uri.parse('${UtilGlobals.baseUrl}/user-register.php');
  //   var headers = {
  //     'Content-Type': 'multipart/form-data',
  //     "Accept":"application/json",
  //   };
  //   final response = await client.post(uri, body: data, headers: headers,);
  //   return response;
  // }

  Future<dynamic> changePassword(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-change-password.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
      uri,
      body: data,
      headers: headers,
    );
    return response;
  }

  Future<dynamic> getHomeBook(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/show-book-home.php?lang=$language');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getUserAllBookByCategory(int id, String language, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-book.php?category=$id&lang=$language&type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> fetchCategoryWiseBook(int id, String language, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-book.php?category=$id&lang=$language&type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getNewRelease(String language, String filter, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/show-new-book.php?lang=$language&filter=$filter&type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getNewReleaseByType(String language, String filter, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/show-new-courses.php?lang=$language&filter=$filter&type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getProductDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('${UtilGlobals.baseUrl}/show-book-detail.php?id=$id');
    final token = prefs.getString('token');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }



  /// Wish List API
  Future<dynamic> getWishList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/wishlist.php');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> addToWishList(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/wishlist.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
      uri,
      body: data,
      headers: headers,
    );
    return response;
  }

  Future<dynamic> deleteFromWishList(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/wishlist.php?item_id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'token': token!,
    };
    final response = await client.delete(uri, headers: headers);
    return response;
  }

  /// Wish list end here


  /// Address API from here

  Future<dynamic> addAddress(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/address.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
      uri,
      body: data,
      headers: headers,
    );
    return response;
  }

  Future<dynamic> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/address.php');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> updateAddress(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/address.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.put(uri, body: json.encode(data), headers: headers);
    return response;
  }

  Future<dynamic> deleteAddress(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/address.php?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'token': token!,
    };
    final response = await client.delete(uri, headers: headers);
    return response;
  }

  /// Address API end here


  /// Cart API start from here

  Future<dynamic> addToCart(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/cart.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
      uri,
      body: data,
      headers: headers,
    );
    return response;
  }

  Future<dynamic> getCartItem() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/cart.php');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> updateCart(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/cart.php');
    var headers = {
      'Content-Type': 'application/json',
      'token': token!,
    };
    final response = await client.put(uri, body: json.encode(data), headers: headers);
    return response;
  }

  Future<dynamic> deleteAItem(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/cart.php?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'token': token!,
    };
    final response = await client.delete(uri, headers: headers);
    return response;
  }

  /// Cart API end here


  /// Order API Start here

  Future<dynamic> getOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/order.php');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> makeOrder(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/order.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
        uri,
        body: json.encode(data),
        headers: headers,
    );
    return response;
  }

  Future<dynamic> deleteOrder(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/order.php?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'token': token!,
    };
    final response = await client.delete(uri, headers: headers);
    return response;
  }

  /// Order API end here

  /// News api integration from here

  Future<dynamic> getCategoriesByType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-category.php?type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getNewReleaseNews(String language, String filter) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/show-new-news.php?lang=$language&filter=$filter');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getNewsDetails(int id) async {
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-news-detail.php?id$id');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Token~~~~~~~$token');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    // print("hfhfhgfgh$response");
    return response;
  }

  Future<dynamic> getCategoryWiseNews(int id, String language) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-news.php?category=$id&lang=$language');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getTypeWiseCategory(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-category.php?type=$type');
    var headers = {
      'token': '$token',
    };
    print("Coming here type ===> $type");
    final response = await client.get(uri, headers: headers);
    return response;
  }

  /// News API end here

  /// About us and terms section

  Future<dynamic> getAboutUsAndTerms() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/aboutus-user.php');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  /// Course api from here

  Future<dynamic> getCategoryWiseCourse(int id, String language, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-courses.php?lang=$language&category=$id&type=$type');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }

  Future<dynamic> getCourseDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-show-courses-detail.php?id=$id');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }


  /// Customer Support API start here

  Future<dynamic> sendMessageToCustomerSupport(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('${UtilGlobals.baseUrl}/user-change-password.php');
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      'token': '$token',
    };
    final response = await client.post(
      uri,
      body: data,
      headers: headers,
    );
    return response;
  }

  /// Customer Support API end here


  /// Quiz API integration

  Future<dynamic> getQuiz(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('${UtilGlobals.baseUrl}/quize-user.php?id=$id');
    final token = prefs.getString('token');
    var headers = {
      'token': '$token',
    };
    final response = await client.get(uri, headers: headers);
    return response;
  }



  /// Quiz API end here

  void close() {
    client.close();
  }
}
