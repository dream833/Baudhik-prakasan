import 'package:get/get.dart';

import '../controllers/e_book_details_controller.dart';

class EBookDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EBookDetailsController>(
      () => EBookDetailsController(),
    );
  }
}
