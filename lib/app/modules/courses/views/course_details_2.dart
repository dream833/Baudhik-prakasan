import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/modules/courses/controllers/course_controller2.dart';

class CourseDetails2 extends StatelessWidget {
  final int id;
  const CourseDetails2({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController2());
    controller.fetchCourseDetails(id);
    controller.getVideo(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details 2'),
      ),
      body: Obx(
        () => controller.isCourseDetailsLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    Image(
                        image: NetworkImage(
                            controller.courseDetails.value?.images![0] ??
                                AppImage.noImage)),
                    Text(id.toString()),
                    Text(
                      controller.courseDetails.value?.description ?? 'null',
                    ),
                    Text(
                      '${controller.courseDetails.value?.id ?? 'null'}',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
