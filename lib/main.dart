import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/modules/login/views/login_view.dart';

import 'app/modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/wishlist/controllers/wishlist_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishlistController());
  await cartController.getCart();
  // await cartController.totalCartItem();
  final SharedPreferences sp = await SharedPreferences.getInstance();
  final token = sp.getString('token') ?? '';
  if (token.isNotEmpty){
    print(token);
  }

  else if (token.isEmpty){
    print('No token found');
  }


  runApp(ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scrollBehavior: const MaterialScrollBehavior(),
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          // home: token.isNotEmpty ? BottomNavigationBarView() : LoginView(),
        );
      }));
}
