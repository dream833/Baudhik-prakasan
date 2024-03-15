import 'package:flutter/material.dart';

import '../../../widgets/app_color.dart';

class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        backgroundColor: AppColor.white50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Video Lecture",
          style: TextStyle(
              color: AppColor.black
          ),
        ),
        iconTheme: IconThemeData(color: AppColor.black),
      ),
    );
  }
}
