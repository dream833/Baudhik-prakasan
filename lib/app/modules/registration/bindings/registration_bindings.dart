import 'package:get/get.dart';
import 'package:ssgc/app/modules/registration/controllers/registration_controllers.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
          () => RegistrationController(),
    );
  }
}
