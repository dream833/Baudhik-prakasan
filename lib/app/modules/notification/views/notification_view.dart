import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/app_image.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/text.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "Notification"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: EmptyView(
            image: AssetImage(AppImage.notification),
            mainText: " No Notification Yet",
            subText: "When You Get Notification, They'll Show Up Here"),
      ),
    );
  }
}
