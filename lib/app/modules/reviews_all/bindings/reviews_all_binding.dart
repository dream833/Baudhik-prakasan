import 'package:get/get.dart';

import '../controllers/reviews_all_controller.dart';

class ReviewsAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsAllController>(
      () => ReviewsAllController(),
    );
  }
}
