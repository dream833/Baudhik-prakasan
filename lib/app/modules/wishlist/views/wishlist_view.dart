import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/modules/product_detail/views/product_detail_view.dart';
import 'package:ssgc/app/widgets/rating.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../data/app_image.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/text.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    controller.getWishList();
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white50,
          title: BigText(text: "Wishlist"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          // bottom: TabBar(
          //   labelPadding: EdgeInsets.symmetric(horizontal: 30),
          //   indicatorColor: AppColor.mainColor,
          //   isScrollable: true,
          //   padding: const EdgeInsets.symmetric(horizontal: 5),
          //   labelColor: AppColor.mainColor,
          //   unselectedLabelColor: Colors.black54,
          //   tabs: const [
          //     Tab(
          //       text: "All",
          //     ),
          //     Tab(
          //       text: "New",
          //     ),
          //     Tab(
          //       text: "National",
          //     ),
          //     Tab(
          //       text: "International",
          //     ),
          //     Tab(
          //       text: "Science",
          //     ),
          //     Tab(
          //       text: "Economics",
          //     ),
          //   ],
          // ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(()=> controller.isWishListLoading.value
              ? Center(child: CircularProgressIndicator(),)
                  : controller.wishList.isEmpty
                  ? EmptyView(
                      image: AssetImage(AppImage.wishlist),
                      mainText: " Your Wishlist is Empty",
                      subText: "Explore More And Shortlist Some Items",
                    )
                  : ListView.builder(
                      itemCount: controller.wishList.length,
                      itemBuilder: (context, index){
                        final wishList = controller.wishList[index];
                        return GestureDetector(
                          onTap: (){
                            print("Type is ${wishList.type}");
                            if (wishList.type == 'book'){
                              Get.to(()=> ProductDetailView(id: wishList.itemId));
                              // Get.toNamed(()=>ProductDetailView(id: wishList.itemId));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h,),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    height: 130.h,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/books.jpg",),
                                    ),
                                  ),
                                  SizedBox(width: 12.w,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Book Name for Item ${wishList.itemId}"),
                                          SizedBox(width: 8.w,),
                                          GestureDetector(
                                            onTap: (){
                                              controller.deleteFromWishList(index, wishList.itemId);
                                              controller.removeFromWishlistSharedPreference(wishList.itemId);
                                            },
                                            child: Icon(Icons.favorite, color: Colors.red,),
                                          ),
                                        ],
                                      ),
                                      Rating(),
                                      Row(
                                        children: [
                                          Text("MRP: 120"),
                                          Text("Sale Price: 120"),
                                        ],
                                      ),
                                      SizedBox(height: 5.h,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RoundedButton(
                                            isLoading: false,
                                            text: "Add to cart", onPress: (){},
                                          ),
                                          SizedBox(width: 10.w,),
                                          RoundedButton(
                                            isLoading: false,
                                            text: "Buy now", onPress: (){},),
                                        ],
                                      )
                                      // Text(wishList.type.toString(),),
                                      // Text(wishList.id.toString()),
                                      // Divider(),
                                    ],
                                  ),
                            ],
                          ),
                  ),
                        );
            },
          ),
          ),

          // TabBarView(
          //   children: [
          //     Obx(()=> controller.isWishListLoading.value
          //         ? Center(child: CircularProgressIndicator(),)
          //         : controller.wishList.isEmpty
          //             ? EmptyView(
          //                 image: AssetImage(AppImage.wishlist),
          //                 mainText: " Your Wishlist is Empty",
          //                 subText: "Explore More And Shortlist Some Items",
          //               )
          //             : ListView.builder(
          //               itemCount: controller.wishList.length,
          //               itemBuilder: (context, index){
          //                 final wishList = controller.wishList[index];
          //                 return Container(
          //                   margin: EdgeInsets.only(top: 10.h,),
          //                   child: Row(
          //                     children: [
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(16),
          //                         child: Image(
          //                           height: 130.h,
          //                           width: 100.w,
          //                           fit: BoxFit.cover,
          //                           image: AssetImage("assets/images/books.jpg",),
          //                         ),
          //                       ),
          //                       SizedBox(width: 12.w,),
          //                       Column(
          //                         mainAxisAlignment: MainAxisAlignment.start,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Text("Book Name for Item ${wishList.itemId}"),
          //                               SizedBox(width: 8.w,),
          //                               GestureDetector(
          //                                 onTap: (){
          //                                   controller.deleteFromWishList(index, wishList.itemId);
          //                                   controller.removeFromWishlistSharedPreference(wishList.itemId);
          //                                 },
          //                                 child: Icon(Icons.favorite, color: Colors.red,),
          //                               ),
          //                             ],
          //                           ),
          //                           Rating(),
          //                           Row(
          //                             children: [
          //                               Text("MRP: 120"),
          //                               Text("Sale Price: 120"),
          //                             ],
          //                           ),
          //                           SizedBox(height: 5.h,),
          //
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               RoundedButton(
          //                                 isLoading: false,
          //                                 text: "Add to cart", onPress: (){},
          //                               ),
          //                               SizedBox(width: 10.w,),
          //                               RoundedButton(
          //                                 isLoading: false,
          //                                 text: "Buy now", onPress: (){},),
          //                             ],
          //                           )
          //                           // Text(wishList.type.toString(),),
          //                           // Text(wishList.id.toString()),
          //                           // Divider(),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 );
          //               },
          //         ),
          //     ),
          //     EmptyView(
          //       image: AssetImage(AppImage.wishlist),
          //       mainText: " Your Wishlist is Empty",
          //       subText: "Explore More And Shortlist Some Items",
          //     ),
          //     EmptyView(
          //         image: AssetImage(AppImage.wishlist),
          //         mainText: " Your Wishlist is Empty",
          //         subText: "Explore More And Shortlist Some Items"),
          //     EmptyView(
          //         image: AssetImage(AppImage.wishlist),
          //         mainText: " Your Wishlist is Empty",
          //         subText: "Explore More And Shortlist Some Items"),
          //     EmptyView(
          //         image: AssetImage(AppImage.wishlist),
          //         mainText: " Your Wishlist is Empty",
          //         subText: "Explore More And Shortlist Some Items"),
          //     EmptyView(
          //         image: AssetImage(AppImage.wishlist),
          //         mainText: " Your Wishlist is Empty",
          //         subText: "Explore More And Shortlist Some Items"),
          //   ],
          // ),
        ),
      ),
    );
  }
}
