import 'package:get/get.dart';

import '../controllers/courses_controllers.dart';

class CoursesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CoursesController>(() => CoursesController());
  }

}