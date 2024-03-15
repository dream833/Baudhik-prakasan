import 'package:get/get.dart';
import 'package:ssgc/app/modules/aboutus/controllers/about_us_controllers.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AboutUsController>(() => AboutUsController(),);
  }

}