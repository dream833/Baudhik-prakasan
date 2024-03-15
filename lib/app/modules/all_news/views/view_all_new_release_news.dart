import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/all_news/controllers/all_news_controllers.dart';
import 'package:ssgc/app/widgets/image_loader.dart';

import '../../../widgets/app_color.dart';
import '../../news_details/views/news_details_view.dart';

class ViewAllNewReleaseNews extends StatelessWidget {
  final String language, type;
  const ViewAllNewReleaseNews({super.key, required this.language, required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllNewsControllers());
    controller.getNewRelease(type, language);
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: Text(
          "All News",
          style: TextStyle(
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white50,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Obx(() => controller.isNewReleaseLoading.value ? CircularProgressIndicator() :
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.newReleaseNews.length,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (context, index){
              final newRelease = controller.newReleaseNews[index];
              return GestureDetector(
                onTap: (){
                  Get.to(() => NewsDetailsView(id: newRelease.newsId,));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 16.h,),
                  child: Row(
                    children: [
                      AppImageLoader(imageUrl: newRelease.image, height: 120.h, width: 100.w),
                      SizedBox(width: 10.w,),
                      Column(
                        children: [
                          Text(
                            controller.newReleaseNews[index].title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.h,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                            controller.newReleaseNews[index].description.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.h,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                          // SizedBox(height: 5.h,),
                          // Text(
                          //   controller.newReleaseNews[index].title.toString(),
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: TextStyle(
                          //       fontSize: 13.h,
                          //       fontWeight: FontWeight.normal
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
          },),
        ),
    );
  }
}


