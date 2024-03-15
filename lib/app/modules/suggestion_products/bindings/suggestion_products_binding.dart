import 'package:get/get.dart';

import '../controllers/suggestion_products_controller.dart';

class SuggestionProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestionProductsController>(
      () => SuggestionProductsController(),
    );
  }
}
