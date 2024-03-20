import 'package:get/get.dart';
import 'package:ssgc/app/modules/buy_now/controllers/buy_now_controllers.dart';

class BuyNowBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyNowController>(
      () => BuyNowController(),
    );
  }
}
