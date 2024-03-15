import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/all_news/controllers/all_news_controllers.dart';
import 'package:ssgc/app/widgets/image_loader.dart';

import '../../../widgets/app_color.dart';
import '../../news_details/views/news_details_view.dart';

class ViewAllNews extends StatelessWidget {
  final int index, id;
  final String language, type, name;
  const ViewAllNews({super.key, required this.index, required this.id, required this.language, required this.type, required this.name});

  @override
  Widget build(BuildContext context) {
    print("Receive id is =====> $id");
    print("Receive index is =====> $index");
    print("Receive type is =====> $type");
    print("Receive language is =====> $language");
    print("Receive name is =====> $name");

    final controller = Get.put(AllNewsControllers());
    controller.viewAllNewsByCategory(id, language);

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
      body: Obx(()=> controller.isViewAllCategoryWiseNewsLoading.value ? Center(child: CircularProgressIndicator()) :
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(bottom: 16.h),
            itemCount: controller.viewAllCategoryWiseNewsList.length,
            itemBuilder: (context, index){
              final allData = controller.viewAllCategoryWiseNewsList[index];
              return GestureDetector(
                onTap: (){
                  Get.to(() => NewsDetailsView(id: allData.id,));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 16.h,),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImageLoader(imageUrl: allData.image, height: 120.h, width: 100.w),
                      SizedBox(width: 10.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allData.title.toString(),
                            style: TextStyle(
                              fontSize: 14.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(
                            allData.description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.h,
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Text(allData.createdAt.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),


      ),
    );
  }
}


