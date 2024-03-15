import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/all_news/views/view_all_new_release_news.dart';
import 'package:ssgc/app/modules/all_news/views/view_all_news.dart';

import '../../../data/app_image.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/detail_page_shimmer.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/image_loader.dart';
import '../../../widgets/tab_bar_shimmer.dart';
import '../../news_details/views/news_details_view.dart';
import '../controllers/all_news_controllers.dart';

class NewsView extends StatelessWidget {
  final String? type;
  const NewsView({super.key, this.type});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AllNewsControllers());
    controller.getCategories(type!);
    controller.getNewRelease(type!, "in");
    controller.getHindiNewRelease(type!);
    controller.getEnglishNewRelease(type!);
    // controller.filterE(type!);

    onRefresh() async {
      controller.getCategories(type!);
      controller.getNewRelease('in', type!);
      controller.getEnglishNewRelease(type!);
      controller.getHindiNewRelease(type!);
    }


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          title: Text("Current News", style: TextStyle(color: AppColor.black,),),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: AppColor.white50,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: Obx(() => controller.isCategoryLoading.value ? const TabBarShimmer() :
            TabBar(
              labelColor: AppColor.black,
              isScrollable: true,
              tabs: const [
                Tab(text: 'हिन्दी'),
                Tab(text: 'English'),
              ],
            ),
            ),
          ),
        ),
        body: Obx(()=> controller.isCategoryLoading.value ? const DetailsPageShimmer() :
        TabBarView(
          children: [
            // First tab item
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: 5.h,),

                  /// Category list horizontal
                  Visibility(
                    visible: !controller.isSelected.value,
                    child: Obx(()=> controller.isCategoryLoading.value
                        ? Container()
                        : GetBuilder<AllNewsControllers>(
                        builder: (controller) {
                          return controller.categories.isEmpty
                              ? Center(child: EmptyView(image: AssetImage(AppImage.empty_cart),))
                              : SizedBox(
                            height: 45,
                            child: ListView.builder(
                              itemCount: controller.categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                final isSelected = controller.selectedIndex.value == index;
                                final category = controller.categories[index];
                                return GestureDetector(
                                  onTap: (){
                                    controller.selectedCategoryName.value = category.name.toString();
                                    controller.selectedCategoryId.value = category.id;
                                    print(controller.selectedCategoryName.value.toString());
                                    controller.toggleItem(index);
                                    // CustomMessage.successToast("Click");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5.w,),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category.name.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                          // FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
                        }
                    ),
                    ),
                  ),

                  /// Showing filter data

                  Visibility(
                    visible: controller.isSelected.value,
                    child: Obx(()=>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Select the item
                            Container(
                              height: 45.h,
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.grey.shade300
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(controller.selectedCategoryName.value.toString(),),
                                  SizedBox(width: 10.w,),
                                  GestureDetector(
                                    onTap: (){
                                      debugPrint('Clicking ------------> ${controller.selectedIndex.value}');
                                      controller.toggleItem(controller.selectedIndex.value);
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 24.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            /// Show filter List
                            Column(
                              children: [
                                SizedBox(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FutureBuilder(
                                        future: controller.filterHindiNews(controller.selectedCategoryId.value, 'in'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          } else {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                if(controller.filterHindiNewsList.isEmpty)
                                                  Container(
                                                    // height: Get.height - 500,
                                                    // margin: EdgeInsets.only(top: 50.h),
                                                    child: EmptyView(
                                                      image: AssetImage(AppImage.empty_cart),
                                                      mainText: "${controller.selectedCategoryName.value.toString()} is Empty",
                                                      subText: "Nothing found for this category",
                                                    ),
                                                  ),
                                                if(controller.filterHindiNewsList.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(controller.selectedCategoryName.value.toString()),
                                                        GestureDetector(
                                                          onTap: (){
                                                            // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                            print("Click");
                                                            print(controller.selectedCategoryName.value.toString());
                                                          },
                                                          child: const Text("View All"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                SizedBox(height: 10.h,),
                                                SizedBox(
                                                  height: 200.h,
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.filterHindiNewsList.length,
                                                      itemBuilder: (context, index){
                                                        final newRelease = controller.filterHindiNewsList[index];
                                                        return GestureDetector(
                                                          onTap: (){
                                                            // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: Colors.grey.shade200,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                AppImageLoader(imageUrl: newRelease.image, height: 150.h, width: 140.w,),
                                                                SizedBox(height: 2.h,),
                                                                Container(
                                                                  width: 140.w,
                                                                  height: 42.h,
                                                                  padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                  child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text(
                                                                        newRelease.title.toString(),
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontSize: 15.h,
                                                                          fontWeight: FontWeight.w400,
                                                                        )
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Container(
                                                                //   width: 140.w,
                                                                //   padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                //   child: Text(
                                                                //     "Sale Price: ${newRelease.mrp.toString()}",
                                                                //     maxLines: 1,
                                                                //     overflow: TextOverflow.ellipsis,
                                                                //     style: TextStyle(
                                                                //         color: AppColor.mainColor,
                                                                //         fontSize: 15,
                                                                //         fontWeight: FontWeight.w500
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                // Text('Type : ${newRelease.type.toString()}',),
                                                                // CustomTextSpan(title: "Sale Price", text: "120"),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ),
                  ),

                  SizedBox(height: 12.h,),

                  /// Showing category wise book list and new release
                  Visibility(
                      visible: !controller.isSelected.value,
                      child: Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// New release section start
                                // NewReleaseNews(language: 'in', type: type!,),
                                Visibility(
                                  visible: !controller.isSelected.value,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("New Release"),
                                            GestureDetector(
                                              onTap: (){
                                                // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                // print("Click");
                                                // Get.to(()=> ViewAllNews());
                                                Get.to(()=> ViewAllNewReleaseNews(language: 'in', type: type!,),);
                                              },
                                              child: Text("View All"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 14.h,),
                                      SizedBox(
                                        height: 220.h,
                                        child: controller.newReleaseHindiNews.isEmpty? const Center(child: Text('No data found'),) : Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            // padding: EdgeInsets.only(right: 0.w,),
                                            itemCount: controller.newReleaseHindiNews.length > 5 ? 5 : controller.newReleaseHindiNews.length,
                                            itemBuilder: (context, index){
                                              final newRelease = controller.newReleaseHindiNews[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                  Get.to(() => NewsDetailsView(id: newRelease.newsId,));
                                                },
                                                child: Container(
                                                  // padding: EdgeInsets.only(left: 0.w),
                                                  margin: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppImageLoader(
                                                        imageUrl: newRelease.image,
                                                        height: 170.h,
                                                        width: 140.w,
                                                      ),
                                                      SizedBox(height: 2.h,),
                                                      Container(
                                                        width: 140.w,
                                                        height: 42.h,
                                                        // color: Colors.red,
                                                        padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              newRelease.title.toString(),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 14.h,
                                                                fontWeight: FontWeight.w400,
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 18.h,),
                                    ],
                                  ),
                                ),
                                /// New release section end

                                /// Category wise news section start
                                Obx(() => controller.isCategoryLoading.value
                                    ? Container()
                                    : ListView.builder(
                                    itemCount: controller.categories.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      final category = controller.categories[index];
                                      final books = controller.categoryWiseNews[category.id] ?? [];
                                      print(books);
                                      return SizedBox(
                                        height: 270.h,
                                        // margin: EdgeInsets.all(10),
                                        // padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(category.name.toString()),
                                                  GestureDetector(
                                                    onTap: (){
                                                      // Get.to(()=> ViewAllNews());
                                                      Get.to(ViewAllNews(
                                                          index: index,
                                                          id: category.id,
                                                          language: "in",
                                                          type: type!,
                                                          name: category.name
                                                      ));
                                                      print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                          "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                      // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                      // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                    },
                                                    child: const Text("View All"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: controller.getCategoryWiseNews(category.id, "in", ),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return Container();
                                                  } else if (snapshot.hasError) {
                                                    return Text("Error: ${snapshot.error}");
                                                  } else {
                                                    return Container(
                                                      height: 235.h,
                                                      margin: EdgeInsets.only(top: 16.h,),
                                                      child: books.isEmpty
                                                          ? const Center(child: Text("No data found"))
                                                          : Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: books.length > 5 ? 5 : books.length,
                                                          itemBuilder: (context, subIndex){
                                                            return GestureDetector(
                                                              onTap: (){

                                                                print("Main index is ------------> ${index + 1 }");
                                                                print("My select category id ----------------> ${subIndex + 1}");
                                                                print("News id is --------------> ${books[subIndex].id}");
                                                                Get.to(() => NewsDetailsView(id: books[subIndex].id,));
                                                              },
                                                              child: Container(
                                                                height: 100.h,
                                                                width: 160.w,
                                                                padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                                // margin: EdgeInsets.only(),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(16.r),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AppImageLoader(
                                                                      imageUrl: books[subIndex].image.toString(),
                                                                      height: 180.h,
                                                                      width: 170.w,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.all(8.0.h),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          '${books[subIndex].title}',
                                                                          maxLines: 2,
                                                                          textAlign: TextAlign.left,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
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
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                                ),
                                /// Category wise news section end
                              ],
                            ),
                          ),
                        ),
                      )
                  )

                ],
              ),
            ),

            // Second tab item

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: 5.h,),

                  /// Category list horizontal
                  Visibility(
                    visible: !controller.isSelected.value,
                    child: Obx(()=> controller.isCategoryLoading.value
                        ? Container()
                        : GetBuilder<AllNewsControllers>(
                        builder: (controller) {
                          return controller.categories.isEmpty
                              ? Center(child: EmptyView(image: AssetImage(AppImage.empty_cart),))
                              : SizedBox(
                            height: 45,
                            child: ListView.builder(
                              itemCount: controller.categories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                final isSelected = controller.selectedIndex.value == index;
                                final category = controller.categories[index];
                                return GestureDetector(
                                  onTap: (){
                                    controller.selectedCategoryName.value = category.name.toString();
                                    controller.selectedCategoryId.value = category.id;
                                    print(controller.selectedCategoryName.value.toString());
                                    controller.toggleItem(index);
                                    // CustomMessage.successToast("Click");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5.w,),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category.name.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                          // FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
                        }
                    ),
                    ),
                  ),

                  /// Showing filter data

                  Visibility(
                    visible: controller.isSelected.value,
                    child: Obx(()=>
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Select the item
                            Container(
                              height: 45.h,
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.grey.shade300
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(controller.selectedCategoryName.value.toString(),),
                                  SizedBox(width: 10.w,),
                                  GestureDetector(
                                    onTap: (){
                                      debugPrint('Clicking ------------> ${controller.selectedIndex.value}');
                                      controller.toggleItem(controller.selectedIndex.value);
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 24.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            /// Show filter List
                            Column(
                              children: [
                                SizedBox(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FutureBuilder(
                                        future: controller.filterEnglishNews(controller.selectedCategoryId.value, 'en'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          } else {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                if(controller.filterEnglishNewsList.isEmpty)
                                                  EmptyView(
                                                    image: AssetImage(AppImage.empty_cart),
                                                    mainText: "${controller.selectedCategoryName.value.toString()} is Empty",
                                                    subText: "Nothing found for this category",
                                                  ),
                                                if(controller.filterEnglishNewsList.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(controller.selectedCategoryName.value.toString()),
                                                        GestureDetector(
                                                          onTap: (){
                                                            // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                            print("Click");
                                                            print(controller.selectedCategoryName.value.toString());
                                                          },
                                                          child: const Text("View All"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                SizedBox(height: 10.h,),
                                                SizedBox(
                                                  height: 200.h,
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.filterEnglishNewsList.length,
                                                      itemBuilder: (context, index){
                                                        final newRelease = controller.filterEnglishNewsList[index];
                                                        return GestureDetector(
                                                          onTap: (){
                                                            // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: Colors.grey.shade200,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                AppImageLoader(imageUrl: newRelease.image, height: 150.h, width: 140.w,),
                                                                SizedBox(height: 2.h,),
                                                                Container(
                                                                  width: 140.w,
                                                                  height: 42.h,
                                                                  padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                  child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text(
                                                                        newRelease.title.toString(),
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontSize: 15.h,
                                                                          fontWeight: FontWeight.w400,
                                                                        )
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Container(
                                                                //   width: 140.w,
                                                                //   padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                //   child: Text(
                                                                //     "Sale Price: ${newRelease.mrp.toString()}",
                                                                //     maxLines: 1,
                                                                //     overflow: TextOverflow.ellipsis,
                                                                //     style: TextStyle(
                                                                //         color: AppColor.mainColor,
                                                                //         fontSize: 15,
                                                                //         fontWeight: FontWeight.w500
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                // Text('Type : ${newRelease.type.toString()}',),
                                                                // CustomTextSpan(title: "Sale Price", text: "120"),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ),
                  ),

                  SizedBox(height: 12.h,),

                  /// Showing category wise book list and new release
                  Visibility(
                      visible: !controller.isSelected.value,
                      child: Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// New release section start
                                // NewReleaseNews(language: 'in', type: type!,),
                                Visibility(
                                  visible: !controller.isSelected.value,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("New Release"),
                                            GestureDetector(
                                              onTap: (){
                                                Get.to(()=> ViewAllNewReleaseNews(language: 'en', type: type!,),);
                                                // Get.to(()=> ViewAllNewRelease(language: 'en', type: type!,));
                                                // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                print("Click");
                                              },
                                              child: const Text("View All"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 14.h,),
                                      SizedBox(
                                        height: 220.h,
                                        child: controller.newReleaseEnglishNews.isEmpty? const Center(child: Text('No data found'),) : Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            // padding: EdgeInsets.only(right: 0.w,),
                                            itemCount: controller.newReleaseEnglishNews.length > 5 ? 5 : controller.newReleaseEnglishNews.length,
                                            itemBuilder: (context, index){
                                              final newRelease = controller.newReleaseEnglishNews[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                  Get.to(() => NewsDetailsView(id: newRelease.newsId,));
                                                },
                                                child: Container(
                                                  // padding: EdgeInsets.only(left: 0.w),
                                                  margin: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppImageLoader(
                                                        imageUrl: newRelease.image,
                                                        height: 170.h,
                                                        width: 140.w,
                                                      ),
                                                      SizedBox(height: 2.h,),
                                                      Container(
                                                        width: 140.w,
                                                        height: 42.h,
                                                        // color: Colors.red,
                                                        padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              newRelease.title.toString(),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 14.h,
                                                                fontWeight: FontWeight.w400,
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 18.h,),
                                    ],
                                  ),
                                ),
                                /// New release section end

                                /// Category wise news section start
                                Obx(() => controller.isCategoryLoading.value
                                    ? Container()
                                    : ListView.builder(
                                    itemCount: controller.categories.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      final category = controller.categories[index];
                                      final books = controller.categoryWiseNews[category.id] ?? [];
                                      print(books);
                                      return SizedBox(
                                        height: 270.h,
                                        // margin: EdgeInsets.all(10),
                                        // padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(category.name.toString()),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Get.to(ViewAllNews(
                                                          index: index,
                                                          id: category.id,
                                                          language: "en",
                                                          type: type!,
                                                          name: category.name
                                                      ));
                                                      print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                          "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                      // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                      // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                    },
                                                    child: const Text("View All"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: controller.getCategoryWiseNews(category.id, "en", ),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return Container();
                                                  } else if (snapshot.hasError) {
                                                    return Text("Error: ${snapshot.error}");
                                                  } else {
                                                    return Container(
                                                      height: 235.h,
                                                      margin: EdgeInsets.only(top: 16.h,),
                                                      child: books.isEmpty
                                                          ? const Center(child: Text("No data found"))
                                                          : Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: books.length > 5 ? 5 : books.length,
                                                          itemBuilder: (context, subIndex){
                                                            return GestureDetector(
                                                              onTap: (){

                                                                print("Main index is ------------> ${index + 1 }");
                                                                print("My select category id ----------------> ${subIndex + 1}");
                                                                print("News id is --------------> ${books[subIndex].id}");
                                                                Get.to(() => NewsDetailsView(id: books[subIndex].id,));
                                                              },
                                                              child: Container(
                                                                height: 100.h,
                                                                width: 160.w,
                                                                padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                                // margin: EdgeInsets.only(),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(16.r),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AppImageLoader(
                                                                      imageUrl: books[subIndex].image.toString(),
                                                                      height: 180.h,
                                                                      width: 170.w,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.all(8.0.h),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          '${books[subIndex].title}',
                                                                          maxLines: 2,
                                                                          textAlign: TextAlign.left,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
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
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                                ),
                                /// Category wise news section end
                              ],
                            ),
                          ),
                        ),
                      )
                  )

                ],
              ),
            ),


            // Column(
            //   children: [
            //     // Category list horizontal
            //     Obx(()=> controller.isCategoryLoading.value ? DetailsPageShimmer()
            //         : SizedBox(
            //             height: controller.isSelected.value ? 400.h : 70.h,
            //             child: GetBuilder<AllNewsControllers>(
            //                 builder: (controller) {
            //                   return Column(
            //                     children: [
            //                       SizedBox(
            //                         height: 50.h,
            //                         child: ListView.builder(
            //                           itemCount: controller.categories.length,
            //                           scrollDirection: Axis.horizontal,
            //                           itemBuilder: (context, index){
            //                             final isSelected = controller.selectedIndex.value == index;
            //                             final category = controller.categories[index];
            //                             return GestureDetector(
            //                               onTap: (){
            //                                 controller.selectedCategoryName.value = category.name.toString();
            //                                 print(controller.selectedCategoryName.value.toString());
            //                                 controller.toggleItem(index);
            //                                 // CustomMessage.successToast("Click");
            //                               },
            //                               child: Container(
            //                                 margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.h, top: 8.h),
            //                                 padding: EdgeInsets.only(left: 16, right: 16,),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius: BorderRadius.circular(5),
            //                                   color: isSelected ? Colors.grey.shade300 : Colors.transparent,
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     category.name.toString(),
            //                                   ),
            //                                 ),
            //                               ),
            //                             );
            //                           },
            //                         ),
            //                       ),
            //                       FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
            //                     ],
            //                   );
            //                 },
            //             ),
            //         ),
            //     ),
            //     Visibility(
            //         visible: !controller.isSelected.value,
            //         child: Expanded(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 /// New release section start
            //                 NewReleaseNews(language: "bn", type: type!,),
            //                 /// New release section end
            //
            //                 /// Category wise news section start
            //                 Obx(() => controller.isCategoryLoading.value
            //                     ? Container()
            //                     : ListView.builder(
            //                         itemCount: controller.categories.length,
            //                         shrinkWrap: true,
            //                         primary: false,
            //                         itemBuilder: (context, index) {
            //                         final category = controller.categories[index];
            //                         print("Category id are------------------> ${category.id}");
            //                         final books = controller.categoryWiseNews[category.id] ?? [];
            //                         print(books);
            //                         return Container(
            //                           height: 290,
            //                           margin: EdgeInsets.all(10),
            //                           padding: EdgeInsets.all(10),
            //                           child: Column(
            //                             children: [
            //                               Row(
            //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(category.name.toString()),
            //                                   GestureDetector(
            //                                     onTap: (){
            //                                       print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
            //                                           "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
            //                                       // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
            //                                     },
            //                                     child: const Text("View All"),
            //                                   ),
            //                                 ],
            //                               ),
            //                               FutureBuilder(
            //                                 future: controller.getCategoryWiseNews(category.id, "en", ),
            //                                 builder: (context, snapshot) {
            //                                   if (snapshot.connectionState == ConnectionState.waiting) {
            //                                     return Container();
            //                                   } else if (snapshot.hasError) {
            //                                     return Text("Error: ${snapshot.error}");
            //                                   } else {
            //                                     return Container(
            //                                       height: 235,
            //                                       margin: EdgeInsets.only(top: 16,),
            //                                       child: books.isEmpty
            //                                           ? Center(child: Text("No data found"))
            //                                           : ListView.builder(
            //                                               shrinkWrap: true,
            //                                               primary: false,
            //                                               scrollDirection: Axis.horizontal,
            //                                               itemCount: books.length,
            //                                               itemBuilder: (context, subIndex){
            //                                                 return GestureDetector(
            //                                                   onTap: (){
            //                                                     Get.to(() => NewsDetailsView(id: books[subIndex].id,));
            //                                                   },
            //                                                   child: Container(
            //                                                     height: 100,
            //                                                     width: 150,
            //                                                     margin: EdgeInsets.only(right: 26,),
            //                                                     // margin: EdgeInsets.only(),
            //                                                     decoration: BoxDecoration(
            //                                                       borderRadius: BorderRadius.circular(16),
            //                                                     ),
            //                                                     child: Column(
            //                                                       mainAxisAlignment: MainAxisAlignment.start,
            //                                                       crossAxisAlignment: CrossAxisAlignment.start,
            //                                                       children: [
            //                                                         AppImageLoader(
            //                                                           imageUrl: books[subIndex].image.toString(),
            //                                                           height: 180,
            //                                                           width: 150,
            //                                                         ),
            //                                                         Container(
            //                                                           padding: const EdgeInsets.all(8.0),
            //                                                           child: Align(
            //                                                             alignment: Alignment.centerLeft,
            //                                                             child: Text(
            //                                                               books[subIndex].title.toString(),
            //                                                               maxLines: 2,
            //                                                               textAlign: TextAlign.left,
            //                                                               overflow: TextOverflow.ellipsis,
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                   ),
            //                                                 );
            //                                               },
            //                                           ),
            //                                       );
            //                                     }
            //
            //                                   },
            //                               ),
            //                             ],
            //                           ),
            //                         );
            //                     },
            //                   ),
            //                 ),
            //                 /// Category wise news section end
            //               ],
            //             ),
            //           ),
            //         )
            //     )
            //
            //   ],
            // ),

            // Second tab item

            // Column(
            //   children: [
            //     // Category list horizontal
            //     Obx(()=> controller.isCategoryLoading.value ? DetailsPageShimmer()
            //         : SizedBox(
            //       height: controller.isSelected.value ? 400.h : 70.h,
            //       child: GetBuilder<AllNewsControllers>(
            //           builder: (controller) {
            //             return Column(
            //               children: [
            //                 SizedBox(
            //                   height: 50.h,
            //                   child: ListView.builder(
            //                     itemCount: controller.categories.length,
            //                     scrollDirection: Axis.horizontal,
            //                     itemBuilder: (context, index){
            //                       final isSelected = controller.selectedIndex.value == index;
            //                       final category = controller.categories[index];
            //                       return GestureDetector(
            //                         onTap: (){
            //                           controller.selectedCategoryName.value = category.name.toString();
            //                           print(controller.selectedCategoryName.value.toString());
            //                           controller.toggleItem(index);
            //                           // CustomMessage.successToast("Click");
            //                         },
            //                         child: Container(
            //                           margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.h, top: 8.h),
            //                           padding: EdgeInsets.only(left: 16, right: 16,),
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(5),
            //                             color: isSelected ? Colors.grey.shade300 : Colors.transparent,
            //                           ),
            //                           child: Center(
            //                             child: Text(
            //                               category.name.toString(),
            //                             ),
            //                           ),
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ),
            //                 FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
            //               ],
            //             );
            //           }
            //       ),
            //     ),
            //     ),
            //
            //     Visibility(
            //         visible: !controller.isSelected.value,
            //         child: Expanded(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 /// New release section start
            //                 Obx(() => controller.isNewReleaseLoading.value
            //                     ? DetailsPageShimmer()
            //                     : Container(
            //                   height: 275,
            //                   margin: EdgeInsets.only(left: 10, right: 10,),
            //                   child: Column(
            //                     children: [
            //                       Container(
            //                         height: 50,
            //                         margin: EdgeInsets.only(left: 16, right: 16,),
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Text("New Release"),
            //                             GestureDetector(
            //                               onTap: (){
            //                                 CustomMessage.successToast("Show all new release news");
            //                               },
            //                               child: Text("View All"),),
            //                           ],
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 225.h,
            //                         child: ListView.builder(
            //                           shrinkWrap: true,
            //                           primary: false,
            //                           scrollDirection: Axis.horizontal,
            //                           itemCount: controller.newReleaseNews.length,
            //                           itemBuilder: (context, index){
            //                             final news = controller.newReleaseNews[index];
            //                             return Container(
            //                               width: 140.w,
            //                               margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h,),
            //                               decoration: BoxDecoration(
            //                                 borderRadius: BorderRadius.circular(16),
            //                                 color: Colors.grey.shade200,
            //                               ),
            //                               child: GestureDetector(
            //                                 onTap: (){
            //                                   Get.to(NewsDetailsView(id: news.newsId));
            //                                   CustomMessage.successToast("New release news ${controller.newReleaseNews[index].newsId.toString()}");
            //                                 },
            //                                 child: Column(
            //                                   crossAxisAlignment: CrossAxisAlignment.start,
            //                                   children: [
            //                                     ClipRRect(
            //                                       borderRadius: BorderRadius.circular(16),
            //                                       child: Image(
            //                                         height: 150,
            //                                         width: 140,
            //                                         fit: BoxFit.cover,
            //                                         image: AssetImage(
            //                                             "assets/images/newspaper.jpg"
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     // AppImageLoader(imageUrl: news.image.toString(), height: 150, width: 100,),
            //                                     Container(
            //                                       width: double.maxFinite,
            //                                       height: 54,
            //                                       padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
            //                                       child: Align(
            //                                         alignment:  Alignment.centerLeft,
            //                                         child: Text(
            //                                           news.title.toString(),
            //                                           maxLines: 2,
            //                                           overflow: TextOverflow.ellipsis,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             );
            //                           },
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 ),
            //                 /// New release section end
            //
            //                 /// Category wise news section start
            //                 Obx(() => controller.isCategoryLoading.value
            //                     ? Container()
            //                     : ListView.builder(
            //                     itemCount: controller.categories.length,
            //                     shrinkWrap: true,
            //                     primary: false,
            //                     itemBuilder: (context, index) {
            //                       final category = controller.categories[index];
            //                       print("Category id are------------------> ${category.id}");
            //                       final books = controller.categoryWiseNews[category.id] ?? [];
            //                       print(books);
            //                       return Container(
            //                         height: 290,
            //                         margin: EdgeInsets.all(10),
            //                         padding: EdgeInsets.all(10),
            //                         child: Column(
            //                           children: [
            //                             Row(
            //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                               children: [
            //                                 Text(category.name.toString()),
            //                                 GestureDetector(
            //                                   onTap: (){
            //                                     print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
            //                                         "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
            //                                     // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
            //                                   },
            //                                   child: const Text("View All"),
            //                                 ),
            //                               ],
            //                             ),
            //                             FutureBuilder(
            //                                 future: controller.getCategoryWiseNews(category.id, "en", ),
            //                                 builder: (context, snapshot) {
            //                                   if (snapshot.connectionState == ConnectionState.waiting) {
            //                                     return Container();
            //                                   } else if (snapshot.hasError) {
            //                                     return Text("Error: ${snapshot.error}");
            //                                   } else {
            //                                     return Container(
            //                                       height: 235,
            //                                       margin: EdgeInsets.only(top: 16,),
            //                                       child: books.isEmpty
            //                                           ? Center(child: Text("No data found"))
            //                                           : ListView.builder(
            //                                         shrinkWrap: true,
            //                                         primary: false,
            //                                         scrollDirection: Axis.horizontal,
            //                                         itemCount: books.length,
            //                                         itemBuilder: (context, subIndex){
            //                                           return GestureDetector(
            //                                             onTap: (){
            //
            //                                               print("Main index is ------------> ${index + 1 }");
            //                                               print("My select category id ----------------> ${subIndex + 1}");
            //                                               print("News id is --------------> ${books[subIndex].id}");
            //                                               Get.to(() => NewsDetailsView(id: books[subIndex].id,));
            //                                             },
            //                                             child: Container(
            //                                               height: 100,
            //                                               width: 150,
            //                                               margin: EdgeInsets.only(right: 26,),
            //                                               // margin: EdgeInsets.only(),
            //                                               decoration: BoxDecoration(
            //                                                 borderRadius: BorderRadius.circular(16),
            //                                               ),
            //                                               child: Column(
            //                                                 mainAxisAlignment: MainAxisAlignment.start,
            //                                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                                 children: [
            //                                                   AppImageLoader(
            //                                                     imageUrl: books[subIndex].image.toString(),
            //                                                     height: 180,
            //                                                     width: 150,
            //                                                   ),
            //                                                   Container(
            //                                                     padding: const EdgeInsets.all(8.0),
            //                                                     child: Align(
            //                                                       alignment: Alignment.centerLeft,
            //                                                       child: Text(
            //                                                         books[subIndex].title.toString(),
            //                                                         maxLines: 2,
            //                                                         textAlign: TextAlign.left,
            //                                                         overflow: TextOverflow.ellipsis,
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           );
            //                                         },
            //                                       ),
            //                                     );
            //                                   }
            //
            //                                 }
            //                             ),
            //                           ],
            //                         ),
            //                       );
            //                     }
            //                 ),
            //                 ),
            //                 /// Category wise news section end
            //               ],
            //             ),
            //           ),
            //         )
            //     )
            //
            //   ],
            // ),
          ],
        ),
        ),
      ),
    );
  }
}

