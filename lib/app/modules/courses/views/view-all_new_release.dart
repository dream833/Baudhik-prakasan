import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/courses/controllers/courses_controllers.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../data/app_image.dart';
import '../../../widgets/empty_widget.dart';
import 'course_details.dart';

class ViewAllNewRelease extends StatelessWidget {
  final String language;
  final String type;
  const ViewAllNewRelease({super.key, required this.language, required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoursesController());
    print("Receive language $language");
    controller.getNewRelease(language, type);
    onRefresh() async {
      controller.getNewRelease(language, type);
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: Text(
          "New Release",
          style: TextStyle(
            color: AppColor.black
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white50,
        iconTheme: IconThemeData(
          color: AppColor.black,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(Icons.list_alt, color: Colors.black,),
          ),
        ],
      ),

      body: Obx(() => controller.isNewReleaseLoading.value
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: controller.newReleaseList.isEmpty
                    ? EmptyView(
                  image: AssetImage(AppImage.empty_cart),
                  mainText: "Ohh... this is Empty",
                  subText: "You will get this Book After Admin Add",
                ) : ListView.builder(
                  itemCount: controller.newReleaseList.length,
                  padding: EdgeInsets.only(left: 20.w, top: 16.h),
                  itemBuilder: (context, index){
                    final newRelease = controller.newReleaseList[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>CourseDetailsView(id: newRelease.id));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Row(
                          children: [
                            AppImageLoader(imageUrl: newRelease.image.toString(), height: 120, width: 100),
                            SizedBox(width: 10.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  newRelease.name.toString(),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  'Sale Price: ${newRelease.mrp.toString()}',
                                  style: TextStyle(
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                SizedBox(height: 8.h,),

                                if(newRelease.isFree == 1)
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
            )
      ),
    );
  }
}
