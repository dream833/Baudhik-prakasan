import 'package:get/get.dart';

import '../controllers/earn_accounts_controller.dart';

class EarnAccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EarnAccountsController>(
      () => EarnAccountsController(),
    );
  }
}
