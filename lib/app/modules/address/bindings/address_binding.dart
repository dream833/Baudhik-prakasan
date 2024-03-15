import 'package:get/get.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';


class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
          () => AddressController(),
    );
  }
}
