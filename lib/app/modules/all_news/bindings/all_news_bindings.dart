import 'package:get/get.dart';
import 'package:ssgc/app/modules/all_news/controllers/all_news_controllers.dart';

class AllNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllNewsControllers>(
      () => AllNewsControllers(),
    );
  }
}
