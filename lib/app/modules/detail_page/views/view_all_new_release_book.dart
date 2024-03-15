import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_image.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/image_loader.dart';
import '../../../widgets/rounded_button.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../controllers/detail_page_controller.dart';

class ViewAllVewReleaseForBook extends StatelessWidget {
  final String type;
  final String language;
  const ViewAllVewReleaseForBook({super.key, required this.type, required this.language});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(DetailPageController());

    controller.getNewRelease(type, language);

    onRefresh() async {
      controller.getNewRelease(type, language);
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
                child: controller.newRelease.isEmpty
                    ? EmptyView(
                      image: AssetImage(AppImage.empty_cart),
                      mainText: "Ohh... this is Empty",
                      subText: "You will get this Book After Admin Add",
                    )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.newRelease.length,
                        padding: EdgeInsets.only(left: 20.w, top: 16.h),
                        itemBuilder: (context, index){
                          final newRelease = controller.newRelease[index];
                          return GestureDetector(
                            onTap: (){
                              print('Click');
                              Get.to(() => ProductDetailView(id: newRelease.bookId, type: type));
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
                                        newRelease.categoryName.toString(),
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

                                      // if(newRelease.isFree == 1)
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

