import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ssgc/app/modules/courses/controllers/courses_controllers.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/empty_widget.dart';

import '../../../data/app_image.dart';
import '../../../widgets/image_loader.dart';
import '../../../widgets/rounded_button.dart';
import 'package:get/get.dart';

import 'course_details.dart';

class ViewAllCategoryWise extends StatelessWidget {
  final int index;
  final int id;
  final String language;
  final String type;
  final String name;

  const ViewAllCategoryWise({super.key, required this.index, required this.id, required this.language, required this.type, required this.name});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CoursesController());
    print("Received id is $id");
    // controller.get
    controller.viewAllCoursesByCategory(id, language, type);


    onRefresh() async {
      controller.viewAllCoursesByCategory(id, language, type);
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        backgroundColor: AppColor.white50,
        title: Text(
          name,
          style: TextStyle(
            color: AppColor.black
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.black,
        ),
        elevation: 0,
      ),
      body: Obx(()=> controller.isViewAllCategoryWiseCourseLoading.value ? Center(child: CircularProgressIndicator()):
        RefreshIndicator(
          onRefresh: onRefresh,
          child: controller.viewAllCategoryWiseCourseList.isEmpty
              ? EmptyView(
                  image: AssetImage(AppImage.empty_cart),
                  mainText: "Ohh... $name is Empty",
                  subText: "You will get $name Book After Admin Add",
                )
              : ListView.builder(
                  itemCount: controller.viewAllCategoryWiseCourseList.length,
                  padding: EdgeInsets.only(bottom: 10.h,),
                  itemBuilder: (context, index){
                    final course = controller.viewAllCategoryWiseCourseList[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>CourseDetailsView(id: course.id));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h,),
                        child: Row(
                          children: [
                            AppImageLoader(imageUrl: course.image.toString(), height: 120, width: 100),
                            SizedBox(width: 10.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  course.name.toString(),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  'Sale Price: ${course.mrp.toString()}',
                                  style: TextStyle(
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                SizedBox(height: 8.h,),

                                if(course.isFree == 1)
                                  Row(
                                    children: [
                                      RoundedButton(
                                        height: 35,
                                        isLoading: false,
                                        text: "Add To Cart",
                                        onPress: (){},
                                      ),

                                      SizedBox(width: 10.w,),

                                      RoundedButton(
                                        height: 35,
                                        isLoading: false,
                                        text: "Buy Now",
                                        onPress: (){},
                                      ),
                                    ],
                                  )
                              ],
                            ),
                        ],
                      ),
              ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

