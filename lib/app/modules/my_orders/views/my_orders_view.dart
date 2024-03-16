import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ssgc/app/modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import 'package:ssgc/app/modules/home/views/home_view.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';

import '../../../data/app_image.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/text.dart';
import '../controllers/my_orders_controller.dart';
import 'package:intl/intl.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(MyOrdersController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white50,
          title: BigText(text: "My Orders"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 50.w),
            indicatorColor: AppColor.mainColor,
            isScrollable: true,
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            labelColor: AppColor.mainColor,
            unselectedLabelColor: Colors.black54,
            tabs: const [
              Tab(
                text: "Your Order",
              ),
              Tab(
                text: "Buy Again",
              ),
            ],
          ),
        ),
        body: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TabBarView(
              children: [
                orderController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : orderController.orderItems.isEmpty
                        ? EmptyView(
                            image: AssetImage(AppImage.wishlist),
                            mainText: " Your Wishlist is Empty",
                            subText: "Explore More And Shortlist Some Items",
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: orderController.orderItems.length,
                                  itemBuilder: (context, index) {
                                    final order = controller.orderItems[index];
                                    final date = order.createdAt;
                                    String formattedDate =
                                        DateFormat.yMd().format(date);
                                    // 12 hour format
                                    String formattedTime = DateFormat('h:mm a')
                                        .format(date); // Date format
                                    // 24 hour format
                                    // String formattedTime = DateFormat.Hm().format(date);
                                    return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Order ID: ${order.id}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    order.status.toString(),
                                                    style: TextStyle(
                                                      color: order.status ==
                                                              "delivered"
                                                          ? Colors.blue
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${formattedDate.toString()} at ${formattedTime.toString()}",
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Row(
                                                children: [
                                                  Image(
                                                    height: 55,
                                                    width: 70,
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/book1.png"),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("Product name"),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomTextSpan(
                                                    title: "TOTAL AMOUNT: ",
                                                    text: order.totalPrice
                                                        .toString(),
                                                  ),
                                                  CustomTextSpan(
                                                    title: "PAYMENT: ",
                                                    text: order.paymentMethod
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (order.status == "pending" ||
                                                  order.status == "canceled")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const IconAndText(
                                                      icon: Icons
                                                          .directions_bike_outlined,
                                                      text: 'Track Order',
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        orderController
                                                            .deleteOrder(
                                                                order.id,
                                                                index);
                                                      },
                                                      child: const IconAndText(
                                                        icon: Icons
                                                            .cancel_outlined,
                                                        text: 'Cancel Order',
                                                        textColor: Colors.red,
                                                        iconColor: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    );
                                  },
                                ),

                                // DataTable(
                                //   columns: [
                                //     DataColumn(
                                //       label: Text("Id",),
                                //     ),
                                //     DataColumn(
                                //     label: Text("Id",),
                                //     ),
                                //     DataColumn(
                                //     label: Text("Id",),
                                //     ),
                                //   ],
                                //   rows: orderController.orderItems.map((order) {
                                //     return DataRow(
                                //       cells: [
                                //         DataCell(Text(order['id'].toString())),
                                //         DataCell(Text(order['status'])),
                                //       ],
                                //     );
                                //   }).toList(),
                                // ),
                              ],
                            ),
                          ),
                EmptyView(
                    image: AssetImage(AppImage.wishlist),
                    mainText: " Your Wishlist is Empty",
                    subText: "Explore More And Shortlist Some Items"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  const IconAndText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
