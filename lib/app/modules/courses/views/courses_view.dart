import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ssgc/app/modules/courses/views/view-all_new_release.dart';
import 'package:ssgc/app/modules/courses/views/view_all_category_wise.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';
import 'package:ssgc/app/widgets/detail_page_shimmer.dart';
import 'package:ssgc/app/widgets/empty_widget.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:ssgc/app/widgets/tab_bar_shimmer.dart';

import '../../../data/app_image.dart';
import '../../../widgets/text.dart';
import '../controllers/courses_controllers.dart';
import 'course_details.dart';
import 'course_details_2.dart';

class CoursesView extends StatelessWidget {
  String? type;
  String? title;
  CoursesView({super.key, this.type, this.title});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CoursesController());
    controller.getCategories(type!);
    controller.getEnglishNewRelease(type!);

    print("Receive type ============> $type");

    onRefresh() async {
      controller.getCategories(type!);
      controller.getNewRelease('in', type!);
      controller.getEnglishNewRelease(type!);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          backgroundColor: AppColor.white50,
          elevation: 0,
          centerTitle: true,
          title:  BigText(text: title!),
          // Text(
          //   title!,
          //   style: TextStyle(
          //     color: AppColor.black
          //   ),
          // ),
          iconTheme: IconThemeData(color: AppColor.black),
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

        body: Obx(()=> controller.isCategoryLoading.value
            ? const SingleChildScrollView(
              child: DetailsPageShimmer(),
            )
            : TabBarView(
              children: [
                /// First Tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: 50, ,
                      // ),
                      SizedBox(height: 5.h,),
                      /// Showing the category here
                      Visibility(
                        visible: !controller.isSelected.value,
                        child: SizedBox(
                          height: 45.h,
                          child: Obx(()=> controller.isCategoryLoading.value ? Container() :
                            GetBuilder<CoursesController>(
                              builder: (controller) {
                                return controller.categories.isEmpty ? const Text("No category found") : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.only(right: 5.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.categories.length,
                                  itemBuilder: (context, index){
                                    final isSelected = controller.selectedIndex.value == index;
                                    final category = controller.categories[index];
                                    return GestureDetector(
                                      onTap: (){
                                        controller.selectCategory(index);
                                        controller.selectedName.value = category.name;
                                        controller.selectedId.value = category.id;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.w,),
                                        padding: EdgeInsets.symmetric(horizontal: 16.w,),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                          child: Text(category.name.toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            ),
                          ),
                        ),
                      ),

                      /// Showing selected category item
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
                                    Text(controller.selectedName.value.toString(),),
                                    SizedBox(width: 10.w,),
                                    GestureDetector(
                                      onTap: (){
                                        print(controller.selectedIndex.value.toString());
                                        controller.selectCategory(controller.selectedIndex.value);
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
                                        future: controller.filterHindiCourse(controller.selectedId.value, 'in', type!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          } else {
                                            print('My Hindi List Length is ========> ${controller.filterHindiCourses.length}');
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                if(controller.filterHindiCourses.isEmpty)
                                                  Container(
                                                    // height: Get.height - 500,
                                                    margin: EdgeInsets.only(top: 50.h),
                                                    child: EmptyView(
                                                      image: AssetImage(AppImage.empty_cart),
                                                      mainText: "${controller.selectedName.value.toString()} is Empty",
                                                      subText: "Nothing found for this category",
                                                    ),
                                                  ),
                                                if(controller.filterHindiCourses.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(controller.selectedName.value.toString()),
                                                        GestureDetector(
                                                          onTap: (){
                                                            // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                            Get.to(ViewAllCategoryWise(
                                                                index: controller.selectedIndex.value,
                                                                id: controller.selectedId.value,
                                                                language: "in",
                                                                type: type!,
                                                              name: controller.selectedName.value
                                                            ));
                                                            print("Click");
                                                            print(controller.selectedName.value.toString());
                                                          },
                                                          child: const Text("View All"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                SizedBox(height: 10.h,),
                                                SizedBox(
                                                  height: 270,
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.filterHindiCourses.length,
                                                      itemBuilder: (context, index){
                                                        final newRelease = controller.filterHindiCourses[index];
                                                        return GestureDetector(
                                                          onTap: (){
                                                            Get.to(()=>CourseDetailsView(id: newRelease.id));
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
                                                                        newRelease.name.toString(),
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontSize: 15.h,
                                                                          fontWeight: FontWeight.w400,
                                                                        )
                                                                    ),
                                                                  ),
                                                                ),

                                                                Container(
                                                                  width: 140.w,
                                                                  padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                  child: Text(
                                                                    "Sale Price: ${newRelease.mrp.toString()}",
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: AppColor.mainColor,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.w500
                                                                    ),
                                                                  ),
                                                                ),
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

                      /// showing selected category item end here

                      SizedBox(height: 10.h,),

                      Visibility(
                        visible: !controller.isSelected.value,
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: onRefresh,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 20.h,),
                                child: Column(
                                  children: [
                                    /// New release start here
                                    Visibility(
                                      visible: !controller.isSelected.value,
                                      child: FutureBuilder(
                                        future: controller.getNewRelease("in", type!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          } else if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          } else {
                                            return controller.newReleaseList.isEmpty
                                                ? Container()
                                                : Container(
                                                    height: 280.h,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("New Release"),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                                  print("Click");
                                                                },
                                                                child: Text("View All"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.h,),
                                                        Container(
                                                          height: 240.h,
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              primary: false,
                                                              scrollDirection: Axis.horizontal,
                                                              // padding: EdgeInsets.only(right: 0.w,),
                                                              itemCount: controller.newReleaseList.length > 5 ? 5 : controller.newReleaseList.length,
                                                              itemBuilder: (context, index){
                                                                final newRelease = controller.newReleaseList[index];
                                                                return GestureDetector(
                                                                  onTap: (){
                                                                    Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                                    // Get.to(()=>CourseDetails2(id: newRelease.id));
                                                                  },
                                                                  child: Container(
                                                                    // padding: EdgeInsets.only(left: 0.w),
                                                                    margin: EdgeInsets.all(10),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                      color: Colors.grey.shade200,
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          AppImageLoader(imageUrl: newRelease.image ?? AppImage.noImage, height: 150.h, width: 140.w,),
                                                                          SizedBox(height: 2.h,),
                                                                          Container(
                                                                            width: 140.w,
                                                                            height: 42.h,
                                                                            padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                            child: Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                newRelease.name ?? '',
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(
                                                                                  fontSize: 14.5.h,
                                                                                  fontWeight: FontWeight.w400,
                                                                                )
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          Container(
                                                                            width: 140.w,
                                                                            padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                            child: Text(
                                                                              "Sale Price: ${newRelease.mrp.toString()}",
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                color: AppColor.mainColor,
                                                                                fontSize: 14.h,
                                                                                fontWeight: FontWeight.w500
                                                                              ),
                                                                            ),
                                                                          ),
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
                                                    ),
                                                );
                                          }
                                        },
                                      ),
                                    ),
                                    /// New release End here

                                    /// Category wise course start here
                                    Obx(() => controller.isCategoryLoading.value
                                        ? Container()
                                        : ListView.builder(
                                            itemCount: controller.categories.length,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemBuilder: (context, index) {
                                              final category = controller.categories[index];
                                              print("Category id are------------------> ${category.id}");
                                              final books = controller.categoryWiseCourses[category.id] ?? [];
                                              print(books);

                                              return SizedBox(
                                                height: 290,
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
                                                              Get.to(ViewAllCategoryWise(
                                                                index: index,
                                                                id: category.id,
                                                                language: "in",
                                                                type: type!,
                                                                name: category.name
                                                              ));
                                                              print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                                  "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                              // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                            },
                                                            child: const Text("View All"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    FutureBuilder(
                                                        future: controller.getCategoryWiseCourse(category.id, "in", type!),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return Container();
                                                          } else if (snapshot.hasError) {
                                                            return Text("Error: ${snapshot.error}");
                                                          } else {
                                                            return Container(
                                                              height: 235,
                                                              margin: EdgeInsets.only(top: 16.h,),
                                                              child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: books.isEmpty ? const Center(child: Text('No data found')) : ListView.builder(
                                                                        shrinkWrap: true,
                                                                        primary: false,
                                                                        // padding: EdgeInsets.only(left: 10,),
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: books.length,
                                                                        itemBuilder: (context, subIndex){
                                                                            return GestureDetector(
                                                                              onTap: (){
                                                                                Get.to(()=>CourseDetailsView(id: books[subIndex].id));
                                                                                print("Main index is ------------> ${index + 1 }");
                                                                                print("My select category id ----------------> ${subIndex + 1}");
                                                                                print("News id is --------------> ${books[subIndex].id}");
                                                                                // Get.to(() => NewsDetailsView(id: books[subIndex].id,));
                                                                              },
                                                                              child: Container(
                                                                                height: 100,
                                                                                width: 170,
                                                                                padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                                                // margin: EdgeInsets.only(right: 26,),
                                                                                // margin: EdgeInsets.only(),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(16),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    AppImageLoader(
                                                                                      imageUrl: books[subIndex].image.toString(),
                                                                                      height: 180,
                                                                                      width: 170,
                                                                                    ),
                                                                                    Container(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Align(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text(
                                                                                          books[subIndex].name.toString(),
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
                                    /// Category wise course end here

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),

                /// Second Tab
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h,),
                      /// Showing the category here
                      Visibility(
                        visible: !controller.isSelected.value,
                        child: SizedBox(
                          height: 45.h,
                          child: Obx(()=> controller.isCategoryLoading.value ? Container() :
                          GetBuilder<CoursesController>(
                              builder: (controller) {
                                return controller.categories.isEmpty ? const Text("No category found") : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.only(right: 5.w),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.categories.length,
                                  itemBuilder: (context, index){
                                    final isSelected = controller.selectedIndex.value == index;
                                    final category = controller.categories[index];
                                    return GestureDetector(
                                      onTap: (){
                                        controller.selectCategory(index);
                                        controller.selectedName.value = category.name;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.w,),
                                        padding: EdgeInsets.symmetric(horizontal: 16.w,),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                          child: Text(category.name.toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                          ),
                          ),
                        ),
                      ),

                      /// Showing selected category item
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
                                      Text(controller.selectedName.value.toString(),),
                                      SizedBox(width: 10.w,),
                                      GestureDetector(
                                        onTap: (){
                                          print(controller.selectedIndex.value.toString());
                                          controller.selectCategory(controller.selectedIndex.value);
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
                                            future: controller.filterEnglishCourse(controller.selectedId.value, 'en', type!),
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
                                                    if(controller.filterEnglishCourses.isEmpty)
                                                      Container(
                                                        // height: Get.height - 500,
                                                        margin: EdgeInsets.only(top: 50.h),
                                                        child: EmptyView(
                                                          image: AssetImage(AppImage.empty_cart),
                                                          mainText: "${controller.selectedName.value.toString()} is Empty",
                                                          subText: "Nothing found for this category",
                                                        ),
                                                      ),
                                                    if(controller.filterEnglishCourses.isNotEmpty)
                                                      Container(
                                                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(controller.selectedName.value.toString()),
                                                            GestureDetector(
                                                              onTap: (){
                                                                // Get.to(()=> ViewAllNewRelease(language: "in", type: type!));
                                                                Get.to(ViewAllCategoryWise(
                                                                    index: controller.selectedIndex.value,
                                                                    id: controller.selectedId.value,
                                                                    language: "en",
                                                                    type: type!,
                                                                    name: controller.selectedName.value
                                                                ));
                                                                print("Click");
                                                                print(controller.selectedName.value.toString());
                                                              },
                                                              child: const Text("View All"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(height: 10.h,),
                                                    SizedBox(
                                                      height: 270,
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: controller.filterEnglishCourses.length,
                                                          itemBuilder: (context, index){
                                                            final newRelease = controller.filterEnglishCourses[index];
                                                            return GestureDetector(
                                                              onTap: (){
                                                                Get.to(()=>CourseDetailsView(id: newRelease.id));
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
                                                                            newRelease.name.toString(),
                                                                            maxLines: 2,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              fontSize: 15.h,
                                                                              fontWeight: FontWeight.w400,
                                                                            )
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Container(
                                                                      width: 140.w,
                                                                      padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                      child: Text(
                                                                        "Sale Price: ${newRelease.mrp.toString()}",
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: AppColor.mainColor,
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w500
                                                                        ),
                                                                      ),
                                                                    ),
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

                      /// showing selected category item end here

                      SizedBox(height: 10.h,),

                      Visibility(
                        visible: !controller.isSelected.value,
                        child: Expanded(
                          child: RefreshIndicator(
                            onRefresh: onRefresh,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, bottom: 20.h,),
                                child: Column(
                                  children: [
                                    /// New release start here
                                    Visibility(
                                      visible: !controller.isSelected.value,
                                      child: controller.englishNewReleaseList.isEmpty ? Container() : SizedBox(
                                              height: 300.h,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("New Release"),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Get.to(()=> ViewAllNewRelease(language: 'en', type: type!,));
                                                            print("Click type $type");
                                                          },
                                                          child: Text("View All"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h,),
                                                  SizedBox(
                                                    height: 240.h,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        scrollDirection: Axis.horizontal,
                                                        padding: EdgeInsets.only(right: 0.w,),
                                                        itemCount: controller.englishNewReleaseList.length,
                                                        itemBuilder: (context, index){
                                                          final newRelease = controller.englishNewReleaseList[index];
                                                          return Container(
                                                            // padding: EdgeInsets.only(left: 0.w),
                                                            margin: EdgeInsets.all(10.h),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: Colors.grey.shade200,
                                                            ),
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                // Get.snackbar("title", "message");
                                                                Get.to(()=> CourseDetailsView(id: newRelease.id));
                                                              },
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
                                                                          newRelease.name.toString(),
                                                                          maxLines: 2,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: const TextStyle(
                                                                            fontSize: 15,
                                                                            fontWeight: FontWeight.w400,
                                                                          )
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  Container(
                                                                    width: 140.w,
                                                                    padding: EdgeInsets.only(left: 8.w, right: 8.w,),
                                                                    child: Text(
                                                                      "Sale Price: ${newRelease.mrp.toString()}",
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          color: AppColor.mainColor,
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w500
                                                                      ),
                                                                    ),
                                                                  ),
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
                                              ),
                                            ),
                                    ),
                                    /// New release End here

                                    /// Category wise course start here
                                    Obx(() => controller.isCategoryLoading.value
                                        ? Container()
                                        : ListView.builder(
                                          itemCount: controller.categories.length,
                                          shrinkWrap: true,
                                          primary: false,
                                          itemBuilder: (context, index) {
                                          final category = controller.categories[index];
                                          print("Category id are------------------> ${category.id}");
                                          final books = controller.categoryWiseCourses[category.id] ?? [];
                                          print(books);

                                          return Container(
                                            height: 276.h,
                                            margin: EdgeInsets.all(10),
                                            // padding: EdgeInsets.all(10),
                                            // color: Colors.red,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(category.name.toString()),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Get.to(
                                                            ViewAllCategoryWise(
                                                              index: index,
                                                              id: category.id,
                                                              language: "en",
                                                              type: type!,
                                                              name: category.name
                                                        ));
                                                        print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                            "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                        // Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                      },
                                                      child: const Text("View All"),
                                                    ),
                                                  ],
                                                ),
                                                FutureBuilder(
                                                    future: controller.getCategoryWiseCourse(category.id, "en", type!),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return Container();
                                                      } else if (snapshot.hasError) {
                                                        return Text("Error: ${snapshot.error}");
                                                      } else {
                                                        return Container(
                                                          height: 230.h,
                                                          // color: Colors.blue,
                                                          margin: EdgeInsets.only(top: 16,),
                                                          child: books.isEmpty
                                                              ? Center(child: Text("No data found"))
                                                              : Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: ListView.builder(
                                                              shrinkWrap: true,
                                                              primary: false,
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: books.length,
                                                              itemBuilder: (context, subIndex){
                                                                return GestureDetector(
                                                                  onTap: (){
                                                                    Get.to(()=>CourseDetailsView(id: books[subIndex].id));
                                                                    print("Main index is ------------> ${index + 1 }");
                                                                    print("My select category id ----------------> ${subIndex + 1}");
                                                                    print("News id is --------------> ${books[subIndex].id}");
                                                                    // Get.to(() => NewsDetailsView(id: books[subIndex].id,));
                                                                  },
                                                                  child: Container(
                                                                    height: 100.h,
                                                                    width: 130.w,
                                                                    margin: EdgeInsets.only(right: 26,),
                                                                    // margin: EdgeInsets.only(),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(16),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        AppImageLoader(
                                                                          imageUrl: books[subIndex].image.toString(),
                                                                          height: 180.h,
                                                                          width: 130.h,
                                                                        ),
                                                                        Container(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Align(
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                              books[subIndex].name.toString(),
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
                                    /// Category wise course end here

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
        ),

      ),
    );
  }

  // void navigateToPetViewPage() async {
  //   Get.to(() {
  //     return ViewAllNewRelease();
  //   });
  //   final controller = Get.find<CoursesController>();
  //   await controller.getNewRelease(language, type);
  // }
}
