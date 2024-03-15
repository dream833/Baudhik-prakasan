import 'package:get/get.dart';
import 'package:ssgc/app/modules/video/controllers/video_controller.dart';

class VideoBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<VideoController>(() => VideoController());
  }

}