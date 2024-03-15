import 'package:get/get.dart';

import '../controllers/quiz_controllers.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<QuizController>(() => QuizController());
  }

}
