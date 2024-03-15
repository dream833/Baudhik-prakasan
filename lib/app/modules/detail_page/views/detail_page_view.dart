import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/catalog_product/views/catalog_product_view.dart';
import 'package:ssgc/app/modules/detail_page/views/view_all_new_release_book.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:ssgc/app/widgets/price_text.dart';
import 'package:ssgc/app/widgets/text.dart';
import 'package:ssgc/app/widgets/titleAndViewAllText.dart';

import '../../../data/app_image.dart';
import '../../../model/category.dart';
import '../../../widgets/book_name_text.dart';
import '../../../widgets/detail_page_shimmer.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/tab_bar_shimmer.dart';
import '../../all_products/views/all_products_view.dart';
import '../../courses/views/view-all_new_release.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../controllers/detail_page_controller.dart';
import 'package:lottie/lottie.dart';

class DetailPageView extends GetView<DetailPageController> {
  String? type;
  DetailPageView({Key? key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    print("Type is -----------------> ${type!}");
    final controller = Get.put(DetailPageController());
    controller.getHindiNewRelease(type!);
    controller.getEnglishNewRelease(type!);

    onRefresh() async {
      // controller.getCategories(type!);
      // controller.getNewRelease('in', type!);
      controller.getEnglishNewRelease(type!);
      controller.getHindiNewRelease(type!);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white50,
          title: BigText(text: "SHOP OUR BOOKS"),
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h,),
            child: Obx(()=> controller.isCategoryLoading.value ? const TabBarShimmer() :
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColor.mainColor,
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "हिन्दी",
                  ),
                  Tab(
                    text: "English",
                  ),
                ],

                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10), // Creates border
                //     color: AppColor.mainColor),
                // tabs: controller.categories.map((category) {
                // return Tab(
                //   text: category.name.toString().isEmpty ? "" : category.name.toString(), // Replace with the actual property name
                //   );
                // }).toList(),
                // onTap: (int index) {
                //   // Toggle the selected tab index when a tab is tapped
                //   if (controller.selectedTabIndex.value == index) {
                //     // Deselect the currently selected tab
                //     controller.setSelectedTabIndex(-1);
                //   } else {
                //     controller.setSelectedTabIndex(index);
                //   }
                // },

              ),
            ),
          ),
        ),
        body:  Obx(()=> controller.isCategoryLoading.value ? const DetailsPageShimmer() : TabBarView(
            children: [
              /// First Tab Item

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),

                    /// Category list horizontal
                    Visibility(
                      visible: !controller.isSelected.value,
                      child: Obx(()=> controller.isCategoryLoading.value
                          ? Container()
                          : GetBuilder<DetailPageController>(
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


                    /// Horizontal listview end here

                    SizedBox(height: 10.h,),

                    /// Show filter data

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
                                          future: controller.filterEnglishBook(controller.selectedCategoryId.value, 'in', type!),
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
                                                  if(controller.filterEnglishBookList.isEmpty)
                                                    EmptyView(
                                                      image: AssetImage(AppImage.empty_cart),
                                                      mainText: "${controller.selectedCategoryName.value.toString()} is Empty",
                                                      subText: "Nothing found for this category",
                                                    ),
                                                  if(controller.filterEnglishBookList.isNotEmpty)
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
                                                              Get.to(AllProductsView(index: controller.selectedIndex.value, id: controller.selectedCategoryId.value, language: "in", type: type));
                                                              // Get.to(()=> ViewAllVewReleaseForBook(language: "in", type: type!));
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
                                                        itemCount: controller.filterEnglishBookList.length,
                                                        itemBuilder: (context, index){
                                                          final newRelease = controller.filterEnglishBookList[index];
                                                          return GestureDetector(
                                                            onTap: (){
                                                              Get.to(() => ProductDetailView(id: newRelease.id, type: type!));
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
                                                                  AppImageLoader(imageUrl: newRelease.image ?? AppImage.noImage, height: 150.h, width: 140.w,),
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
                                                                            fontSize: 13.h,
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


                    // Obx(()=> controller.isCategoryLoading.value ? Container() :
                    //   SizedBox(
                    //     height: controller.isSelected.value ? 400 : 65,
                    //     child:  GetBuilder<DetailPageController>(
                    //       builder: (controller) {
                    //         return Column(
                    //           children: [
                    //             SizedBox(
                    //               height: 65,
                    //               child: ListView.builder(
                    //                 shrinkWrap: true,
                    //                 primary: false,
                    //                 itemCount: controller.categories.length,
                    //                 scrollDirection: Axis.horizontal,
                    //                 itemBuilder: (context, index){
                    //                   final isSelected = controller.selectedIndex.value == index;
                    //                   final category = controller.categories[index];
                    //                   return GestureDetector(
                    //                     onTap: (){
                    //                       controller.toggleItem(index);
                    //                       controller.selectedCategoryName.value = category.name.toString();
                    //                       print("Selected main category --------------> ${index + 1}");
                    //                     },
                    //                     child: Container(
                    //                       padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    //                       margin: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                    //                       decoration: BoxDecoration(
                    //                           color: isSelected  ? Colors.grey.shade200 : Colors.transparent,
                    //                           borderRadius: BorderRadius.circular(10)
                    //                       ),
                    //                       child: Center(
                    //                         child: Text(
                    //                           category.name.toString(),
                    //                           style: TextStyle(
                    //                             color: Colors.black,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //             FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
                    //           ],
                    //         );
                    //       }
                    //     ),
                    //   ),
                    // ),

                    Visibility(
                      visible: !controller.isSelected.value,
                      child: Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// Show here new release data

                                // NewRelease(type: type!, language: "in"),
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
                                                Get.to(()=> ViewAllVewReleaseForBook(language: "in", type: type!));
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
                                        child: controller.newReleaseHindiBook.isEmpty? const Center(child: Text('No data found'),) : Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            // padding: EdgeInsets.only(right: 0.w,),
                                            itemCount: controller.newReleaseHindiBook.length > 5 ? 5 : controller.newReleaseHindiBook.length,
                                            itemBuilder: (context, index){
                                              final newRelease = controller.newReleaseHindiBook[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                  Get.to(() => ProductDetailView(id: newRelease.bookId, type: type!));
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
                                                              newRelease.bookName.toString(),
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

                                /// Showing category wise all the data
                                Obx(() => controller.isCategoryLoading.value
                                    ? Container()
                                    : ListView.builder(
                                      itemCount: controller.categories.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) {
                                        final category = controller.categories[index];
                                        final books = controller.categoryWiseBooks[category.id] ?? [];
                                        return SizedBox(
                                          height: 290.h,
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
                                                        print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                            "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                        Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                      },
                                                      child: const Text("View All"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FutureBuilder(
                                                future: controller.getUserAllBookByCategory(category.id, "in", type!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(child: CircularProgressIndicator());
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
                                                                  itemCount: books.length < 3 ? books.length : 3,
                                                                  itemBuilder: (context, subIndex){
                                                                    return GestureDetector(
                                                                      onTap: (){
                                                                        print("Main index is ------------> ${index + 1 }");
                                                                        print("My select category id ----------------> ${subIndex + 1}");
                                                                        print("Book id is --------------> ${books[subIndex].id}");
                                                                        Get.to(() => ProductDetailView(id: books[subIndex].id, type: type!));
                                                                      },
                                                                      child: Container(
                                                                        height: 100.h,
                                                                        width: 160.w,
                                                                        padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                                                                        // margin: EdgeInsets.only(right: 26,),
                                                                        // margin: EdgeInsets.only(),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(16),
                                                                          // color: Colors.grey.shade200,
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            AppImageLoader(
                                                                              imageUrl: books[subIndex].image.toString(),
                                                                              height: 180.h,
                                                                              width: 160.w,
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.all(8.h),
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
                                                                            Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                              child: Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  'Sale Price: ${books[subIndex].mrp}',
                                                                                  maxLines: 1,
                                                                                  textAlign: TextAlign.left,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(
                                                                                    color: AppColor.mainColor
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            // Text(books[subIndex].name.toString()),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              /// Second Tab Item

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),

                    /// Category list horizontal
                    Visibility(
                      visible: !controller.isSelected.value,
                      child: Obx(()=> controller.isCategoryLoading.value
                          ? Container()
                          : GetBuilder<DetailPageController>(
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


                    /// Horizontal listview end here

                    SizedBox(height: 10.h,),

                    /// Show filter data

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
                                          future: controller.filterEnglishBook(controller.selectedCategoryId.value, 'en', type!),
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
                                                  if(controller.filterEnglishBookList.isEmpty)
                                                    EmptyView(
                                                      image: AssetImage(AppImage.empty_cart),
                                                      mainText: "${controller.selectedCategoryName.value.toString()} is Empty",
                                                      subText: "Nothing found for this category",
                                                    ),
                                                  if(controller.filterEnglishBookList.isNotEmpty)
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
                                                              Get.to(AllProductsView(index: controller.selectedIndex.value, id: controller.selectedCategoryId.value, language: "en", type: type));
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
                                                        itemCount: controller.filterEnglishBookList.length,
                                                        itemBuilder: (context, index){
                                                          final newRelease = controller.filterEnglishBookList[index];
                                                          return GestureDetector(
                                                            onTap: (){

                                                              // Get.to(()=>CourseDetailsView(id: newRelease.id));
                                                              Get.to(() => ProductDetailView(id: newRelease.id, type: type!));
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
                                                                            fontSize: 13.h,
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


                    // Obx(()=> controller.isCategoryLoading.value ? Container() :
                    //   SizedBox(
                    //     height: controller.isSelected.value ? 400 : 65,
                    //     child:  GetBuilder<DetailPageController>(
                    //       builder: (controller) {
                    //         return Column(
                    //           children: [
                    //             SizedBox(
                    //               height: 65,
                    //               child: ListView.builder(
                    //                 shrinkWrap: true,
                    //                 primary: false,
                    //                 itemCount: controller.categories.length,
                    //                 scrollDirection: Axis.horizontal,
                    //                 itemBuilder: (context, index){
                    //                   final isSelected = controller.selectedIndex.value == index;
                    //                   final category = controller.categories[index];
                    //                   return GestureDetector(
                    //                     onTap: (){
                    //                       controller.toggleItem(index);
                    //                       controller.selectedCategoryName.value = category.name.toString();
                    //                       print("Selected main category --------------> ${index + 1}");
                    //                     },
                    //                     child: Container(
                    //                       padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    //                       margin: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                    //                       decoration: BoxDecoration(
                    //                           color: isSelected  ? Colors.grey.shade200 : Colors.transparent,
                    //                           borderRadius: BorderRadius.circular(10)
                    //                       ),
                    //                       child: Center(
                    //                         child: Text(
                    //                           category.name.toString(),
                    //                           style: TextStyle(
                    //                             color: Colors.black,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //             FilterBookList(index: controller.selectedIndex.value < 0 ? 1 : controller.selectedIndex.value, type: type!,),
                    //           ],
                    //         );
                    //       }
                    //     ),
                    //   ),
                    // ),

                    Visibility(
                      visible: !controller.isSelected.value,
                      child: Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// Show here new release data

                                // NewRelease(type: type!, language: "in"),
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
                                                Get.to(()=> ViewAllVewReleaseForBook(language: "en", type: type!));
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
                                        child: controller.newReleaseEnglishBook.isEmpty? const Center(child: Text('No data found'),) : Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            // padding: EdgeInsets.only(right: 0.w,),
                                            itemCount: controller.newReleaseEnglishBook.length,
                                            itemBuilder: (context, index){
                                              final newRelease = controller.newReleaseEnglishBook[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  Get.to(() => ProductDetailView(id: newRelease.bookId, type: type!));
                                                  // Get.to(()=>CourseDetailsView(id: newRelease.id));
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
                                                        imageUrl: newRelease.image ?? AppImage.noImage,
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
                                                              newRelease.bookName.toString(),
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

                                /// Showing category wise all the data
                                Obx(() => controller.isCategoryLoading.value
                                    ? Container()
                                    : ListView.builder(
                                    itemCount: controller.categories.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      final category = controller.categories[index];
                                      final books = controller.categoryWiseBooks[category.id] ?? [];
                                      return Container(
                                        height: 290.h,
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
                                                      print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
                                                          "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
                                                      Get.to(AllProductsView(index: index, id: category.id, language: "in", type: type));
                                                    },
                                                    child: const Text("View All"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: controller.getUserAllBookByCategory(category.id, "en", type!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Center(child: CircularProgressIndicator());
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
                                                        itemCount: books.length < 3 ? books.length : 3,
                                                        itemBuilder: (context, subIndex){
                                                            return GestureDetector(
                                                              onTap: (){
                                                                print("Main index is ------------> ${index + 1 }");
                                                                print("My select category id ----------------> ${subIndex + 1}");
                                                                print("Book id is --------------> ${books[subIndex].id}");
                                                                // Get.to(() => ProductDetailView(id: books[subIndex].id, type: type!,));
                                                                Get.to(() => ProductDetailView(id: books[subIndex].id, type: type!));
                                                              },
                                                              child: Container(
                                                                height: 100.h,
                                                                width: 160.w,
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
                                                                      height: 180.h,
                                                                      width: 150.w,
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
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(
                                                                          'Sale Price: ${books[subIndex].mrp}',
                                                                          maxLines: 1,
                                                                          textAlign: TextAlign.left,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                            color: AppColor.mainColor,
                                                                          ),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              // Column(
              //   children: [
              //
              //     Obx(()=> controller.isCategoryLoading.value ? const Center(child: CircularProgressIndicator()) :
              //     SizedBox(
              //       height: controller.isSelected.value ? 400 : 65,
              //       child:  GetBuilder<DetailPageController>(
              //           builder: (controller) {
              //             return Column(
              //               children: [
              //                 SizedBox(
              //                   height: 65,
              //                   child: ListView.builder(
              //                     shrinkWrap: true,
              //                     primary: false,
              //                     itemCount: controller.categories.length,
              //                     scrollDirection: Axis.horizontal,
              //                     itemBuilder: (context, index){
              //                       final isSelected = controller.selectedIndex.value == index;
              //                       final category = controller.categories[index];
              //                       return GestureDetector(
              //                         onTap: (){
              //                           controller.toggleItem(index);
              //                           controller.selectedCategoryName.value = category.name.toString();
              //                           print("Selected main category --------------> ${index + 1}");
              //                         },
              //                         child: Container(
              //                           padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              //                           margin: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
              //                           decoration: BoxDecoration(
              //                               color: isSelected  ? Colors.grey.shade200 : Colors.transparent,
              //                               borderRadius: BorderRadius.circular(10)
              //                           ),
              //                           child: Center(
              //                             child: Text(
              //                               category.name.toString(),
              //                               style: const TextStyle(
              //                                 color: Colors.black,
              //                               ),
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
              //       visible: !controller.isSelected.value,
              //       child: Expanded(
              //         child: SingleChildScrollView(
              //           child: Column(
              //             children: [
              //               /// Show here new release data
              //
              //               NewRelease(type: type!, language: 'en',),
              //
              //               /// Showing category wise all the data
              //               Obx(() => controller.isCategoryLoading.value
              //                   ? Center(child: CircularProgressIndicator(),)
              //                   : ListView.builder(
              //                     itemCount: controller.categories.length,
              //                     shrinkWrap: true,
              //                     primary: false,
              //                     itemBuilder: (context, index) {
              //                     final category = controller.categories[index];
              //                     final books = controller.categoryWiseBooks[category.id] ?? [];
              //                     return Container(
              //                       height: 290,
              //                       margin: EdgeInsets.all(10),
              //                       padding: EdgeInsets.all(10),
              //                       child: Column(
              //                         children: [
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Text(category.name.toString()),
              //                               GestureDetector(
              //                                 onTap: (){
              //                                   print("CLICK FOR VIEW ALL CATEGORY -----------> ${index + 1}"
              //                                       "\nCLICK ITEM CATEGORY ID IS -----------> ${category.id}");
              //                                   Get.to(AllProductsView(index: index, id: category.id, language: "en"));
              //                                 },
              //                                 child: const Text("View All"),
              //                               ),
              //                             ],
              //                           ),
              //                           FutureBuilder(
              //                               future: controller.getUserAllBookByCategory(category.id, "en", type!),
              //                               builder: (context, snapshot) {
              //                                 if (snapshot.connectionState == ConnectionState.waiting) {
              //                                   return const Center(child: CircularProgressIndicator());
              //                                 } else if (snapshot.hasError) {
              //                                   return Text("Error: ${snapshot.error}");
              //                                 } else {
              //                                   return Container(
              //                                     height: 235,
              //                                     margin: EdgeInsets.only(top: 16,),
              //                                     child: books.isEmpty
              //                                         ? Center(child: Text("No data found"))
              //                                         : ListView.builder(
              //                                       shrinkWrap: true,
              //                                       primary: false,
              //                                       scrollDirection: Axis.horizontal,
              //                                       itemCount: books.length < 3 ? books.length : 3,
              //                                       itemBuilder: (context, subIndex){
              //                                         return GestureDetector(
              //                                           onTap: (){
              //                                             print("Main index is ------------> ${index + 1 }");
              //                                             print("My select category id ----------------> ${subIndex + 1}");
              //                                             print("Book id is --------------> ${books[subIndex].id}");
              //                                             Get.to(() => ProductDetailView(id: books[subIndex].id, type: type!,));
              //                                           },
              //                                           child: Container(
              //                                             height: 100,
              //                                             width: 150,
              //                                             margin: EdgeInsets.only(right: 26,),
              //                                             // margin: EdgeInsets.only(),
              //                                             decoration: BoxDecoration(
              //                                               borderRadius: BorderRadius.circular(16),
              //                                             ),
              //                                             child: Column(
              //                                               mainAxisAlignment: MainAxisAlignment.start,
              //                                               crossAxisAlignment: CrossAxisAlignment.start,
              //                                               children: [
              //                                                 AppImageLoader(
              //                                                   imageUrl: books[subIndex].image.toString(),
              //                                                   height: 180,
              //                                                   width: 150,
              //                                                 ),
              //                                                 Container(
              //                                                   padding: const EdgeInsets.all(8.0),
              //                                                   child: Align(
              //                                                     alignment: Alignment.centerLeft,
              //                                                     child: Text(
              //                                                       books[subIndex].name.toString(),
              //                                                       maxLines: 2,
              //                                                       textAlign: TextAlign.left,
              //                                                       overflow: TextOverflow.ellipsis,
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                         );
              //                                       },
              //                                     ),
              //                                   );
              //                                 }
              //
              //                               }
              //                           ),
              //                         ],
              //                       ),
              //                     );
              //                   }
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

            ],
          ),
        ),
      ),
    );
  }
}

class FilterBookList extends StatelessWidget {
  final int index;
  final String type;
  const FilterBookList({super.key, required this.index, required this.type,});

  @override
  Widget build(BuildContext context) {
    final DetailPageController controller = Get.put(DetailPageController());
    final category = controller.categories[index];
    var categoryId = category.id;
    print("Received Index and category id is $index and $categoryId");
    return GetBuilder<DetailPageController>(
        builder: (controller) {
          return Visibility(
            visible: controller.isSelected.value,
            child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index){
                // final myIndex = controller.categories.length;
                // print("My index is ============> $myIndex");
                final category = controller.categories[index];
                print(" My Category    ${category.id}");
                print(" My Category Name    ${category.name}");
                print(" My Index    $index");
                final books = controller.categoryWiseBooks[categoryId] ?? [];
                return Container(
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.selectedCategoryName.value.isEmpty ? "Select first" : controller.selectedCategoryName.value),
                            GestureDetector(
                              onTap: (){
                                // print("Category Id for filter product -------------> ${books[index].id}");
                              },
                              child: Text("View All"),
                            ),
                          ],
                        ),
                      ),
                      // TitleAndViewAll(index: index ,text: controller.selectedCategoryName.value.isEmpty ? "Select first" : controller.selectedCategoryName.value),
                      const SizedBox(height: 10,),

                      Container(
                        height: 260,
                        margin: const EdgeInsets.only(bottom: 20, top:  10,),
                        child: FutureBuilder(
                          future: controller.getUserAllBookByCategory(5, "in", type),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              return SizedBox(
                                  height: 210,
                                  child: books.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: books.length,
                                          padding: const EdgeInsets.only(right: 10),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, subIndex) {
                                            final book = books[subIndex];
                                            print("Sub Category length ==========> $book");
                                            // final books = controller.userCategoryWiseBooks;
                                            return GestureDetector(
                                              onTap: (){
                                                print("Click ${book.id}");
                                                Get.to(() => ProductDetailView(id: book.id, type: type!));
                                              },
                                              child: Container(
                                                width: 160,
                                                padding: EdgeInsets.only(left: 10, right: 10,),
                                                margin: EdgeInsets.only(left: 10,),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(10) ,
                                                      child: AppImageLoader(
                                                        imageUrl: books[subIndex].image.toString(),
                                                        height: 180,
                                                        width: 150,
                                                      ),

                                                    ),
                                                    SizedBox(height: 5,),
                                                    BookNameText(text: book.name.toString(),),
                                                    SizedBox(height: 5,),
                                                    PriceText(text: "Sale Price: ${book.mrp.toString()}",),
                                                    // Text(book.name.toString(), style: TextStyle(color: Colors.black),),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: const Text("No data found"),
                                        )
                              );
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          );
        }
    );
  }
}


class NewRelease extends StatelessWidget {
  final String type;
  final String language;
  const NewRelease({super.key, required this.type, required this.language});

  @override
  Widget build(BuildContext context) {

    DetailPageController controller = Get.find<DetailPageController>();
    controller.getNewRelease(language, type);
    return Column(
      children: [
        // const TitleAndViewAll(index: 1,text: "New Release"),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("New Release"),
              GestureDetector(
                onTap: (){
                  // Get.to(AllProductsView(id: category.id, language: "en"));
                },
                child: Text("View All"),
              ),
            ],
          ),
        ),
        Container(
          height: 230,
          margin: const EdgeInsets.only(bottom: 20, top:  10,),
          child: SizedBox(
            height: 240,
            child: FutureBuilder(
              future: controller.getNewRelease(type, language),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }else{
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(right: 10),
                    itemCount: controller.newRelease.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final newRelease = controller.newRelease[index];
                      return GestureDetector(
                        onTap: (){
                          print("Click ${index + 1}");
                          Get.to(() => ProductDetailView(id: newRelease.bookId, type: type!));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10,),
                          margin: EdgeInsets.only(left: 10,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10) ,
                                child: AppImageLoader(
                                  imageUrl: newRelease.image.toString(),
                                  height: 180,
                                  width: 150,
                                ),
                              ),
                              SizedBox(height: 5,),
                              BookNameText(text: newRelease.bookName.toString(),),
                              SizedBox(height: 5,),
                              // PriceText(text: "Sale Price: ${book.mrp.toString()}",),
                              // SizedBox(height: 5,),
                              // Text(newRelease.bookName.toString()),
                              // Text(controller.newRelease[index].book_name.toString(), style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

              },),
          ),
        ),
      ],
    );
  }
}




