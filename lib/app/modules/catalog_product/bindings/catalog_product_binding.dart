import 'package:get/get.dart';

import '../controllers/catalog_product_controller.dart';

class CatalogProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatalogProductController>(
      () => CatalogProductController(),
    );
  }
}
