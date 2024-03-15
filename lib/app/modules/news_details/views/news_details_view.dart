import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/news_details/controllers/news_details_controller.dart';

import '../../../widgets/app_color.dart';

class NewsDetailsView extends StatelessWidget {
  int? id;
  NewsDetailsView({super.key, this.id,});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsDetailsController());
    // controller.getNewsDetails();
    controller.fetchNewsDetails(id!);
    print('News id ----> $id');


    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: Text(
          "News Details",
          style: TextStyle(
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white50,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Obx(() {
            if (controller.isLoading.value) {
              return CircularProgressIndicator();
            } else if (controller.newsDetails.value != null) {
              final news = controller.newsDetails.value!; // Use the null check operator to assert it's not null
              final createdAt = news.createdAt;
              final formattedDate = createdAt != null
                  ? '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}'
                  : '';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 240.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10,),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(news.image ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Title: ${news.title ?? ''}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.h,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Description: ${news.description ?? 'No description found!'}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.h,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Date: ${formattedDate != '' ? formattedDate : 'No date available'}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.h,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Added By: ${news.addedBy ?? ''}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13.h,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              );
            } else {
            return Center(child: CircularProgressIndicator()); // Handle case where newsDetails is null
            }
          }),


        ),
      ),
      // body: Obx(() =>
      // ),
    );
  }
}
