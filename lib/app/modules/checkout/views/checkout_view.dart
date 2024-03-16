import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:ssgc/app/modules/address/controllers/address_controller.dart';
import 'package:ssgc/app/modules/address/views/show_address_view.dart';
import 'package:ssgc/app/modules/cart/controllers/cart_controller.dart';
import 'package:ssgc/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:ssgc/app/modules/checkout/phonepe_payment_controller/phonepe_payment_controller.dart';
import 'package:ssgc/app/modules/profile/views/profile_view.dart';
import 'package:ssgc/app/widgets/Shimmer/checkout_shimmer/checkout_body_shimmer.dart';
import 'package:ssgc/app/widgets/Shimmer/checkout_shimmer/checkout_bottom_shimmer.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/custom_message.dart';
import 'package:ssgc/app/widgets/custom_text_span.dart';
import 'package:ssgc/app/widgets/outline_button.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';

import '../../../widgets/image_loader.dart';
import '../../../widgets/rating.dart';
import '../../../widgets/text.dart';
import '../../bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../../cart/views/cart_view.dart';
import '../../my_orders/controllers/my_orders_controller.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  void initState() {
    super.initState();
    phonePeInit();
    body = getChecksum().toString();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.put(CheckoutController());
    final addressController = Get.put(AddressController());
    final cartController = Get.find<CartController>();
    final orderController = Get.put(MyOrdersController());
    // final cartController = Get.find<CartController>();
    final totalPrice = cartController.calculateTotalCartPrice().toString();

    onRefresh() async {
      cartController.getCart();
      cartController.calculateTotalCartPrice();
      addressController.getUserData();
      addressController.getAddress();
    }

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            child: Obx(
              () => cartController.isCartItemLoading.value
                  ? const CheckoutBodyShimmer()
                  : Column(
                      children: [
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: cartController.cartItems.length,
                            padding: EdgeInsets.only(bottom: 10.h),
                            itemBuilder: (context, index) {
                              final cartItem = cartController.cartItems[index];

                              return Container(
                                // color: Colors.red,
                                margin: EdgeInsets.only(top: 10.h),
                                child: Column(
                                  children: [
                                    // Book image and text
                                    Row(
                                      children: [
                                        // Book image
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: AppImageLoader(
                                              imageUrl:
                                                  cartItem.image.toString(),
                                              height: 90,
                                              width: 75),
                                        ),
                                        // Name price, quantity, review section
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Book name
                                                SmallText(
                                                  text: cartItem.name ?? '',
                                                  size: 14.h,
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                RatingQuantityMrp(index: index),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                SmallText(
                                                  text:
                                                      "Sale Price: ₹${cartItem.price ?? 0}",
                                                  size: 12.h,
                                                ),
                                                GetBuilder<CartController>(
                                                    builder: (context) {
                                                  return SmallText(
                                                    text:
                                                        "Total Price: ₹${cartItem.totalPrice ?? 0}",
                                                    size: 12.h,
                                                  );
                                                }),
                                                // SmallText(text: "Total Price: ₹${cartItem.total_price ?? 0}", size: 12,),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                14.0), // Adjust the radius as needed
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 14,
                              bottom: 14,
                            ),
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "My Information",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => ProfileView(),
                                          );
                                        },
                                        child: const Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  CustomTextSpan(
                                      title: "Name: ",
                                      text: checkoutController.userName.value
                                          .toString()),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  CustomTextSpan(
                                      title: "Phone: ",
                                      text: checkoutController.userPhone.value),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                14.0), // Adjust the radius as needed
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 14,
                              bottom: 14,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Delivery",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(const ShowAddressView());
                                      },
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Obx(
                                  () => addressController.isAddressLoading.value
                                      ? const CircularProgressIndicator()
                                      : addressController.addressList.isEmpty
                                          ? const Text("No address found")
                                          : CustomTextSpan(
                                              title: "Delivery Address: ",
                                              text:
                                                  "${addressController.addressList[0].state.toString()}, "
                                                  "${addressController.addressList[0].city.toString()}, "
                                                  "${addressController.addressList[0].area.toString()}, "
                                                  "${addressController.addressList[0].landmark.toString()}, "
                                                  "${addressController.addressList[0].addressLine1.toString()}, "
                                                  "${addressController.addressList[0].addressLine2.toString()}, "
                                                  "${addressController.addressList[0].postalCode.toString()}"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  14.0), // Adjust the radius as needed
                            ),
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 14,
                                bottom: 14,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Payment Method",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('PHONE PAY'),
                                    value: 'phonepay',
                                    groupValue:
                                        checkoutController.selectedValue.value,
                                    onChanged: (value) {
                                      checkoutController
                                          .updateSelectedValue(value!);
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text('ccavenu'),
                                    value: 'ccavenu',
                                    groupValue:
                                        checkoutController.selectedValue.value,
                                    onChanged: (value) {
                                      checkoutController
                                          .updateSelectedValue(value!);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                14.0), // Adjust the radius as needed
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              top: 14.h,
                              bottom: 14.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Order Summary",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                OrderSummary(
                                    text: "Order Subtotal",
                                    amount: "₹ ${totalPrice.toString()}"),
                                const OrderSummary(
                                    text: "Discount On Sale", amount: "₹0.00"),
                                // OrderSummary(text: "Delivery fee", amount: "₹40.00"),
                                // OrderSummary(text: "Coin Points Discount", amount: "₹100.00"),
                                const Divider(),
                                OrderSummary(
                                    text: "Total Amount",
                                    amount: "₹ ${totalPrice.toString()}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => cartController.isCartItemLoading.value
            ? const CheckoutBottomShimmer()
            : Container(
                margin: EdgeInsets.only(right: 10.w),
                height: 65.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: OutlineButton(
                        onPress: () {},
                        text:
                            "₹ ${Get.find<CartController>().calculateTotalCartPrice().toStringAsFixed(2)}",
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: RoundedButton(
                        isLoading: orderController.isCreateOrderLoading.value,
                        text: 'Proceed to pay',
                        onPress: () {
                          if (checkoutController.selectedValue.value ==
                                  'phonepay' ||
                              checkoutController.selectedValue.value ==
                                  'ccavenu') {
                            // CustomMessage.errorToast('Select payment method is ${checkoutController.selectedValue.value}');
                            startPGTransaction();
                            orderController.createOrder();
                          } else {
                            CustomMessage.errorToast(
                                'Please select payment method');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void phonePeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPGTransaction() async {
    try {
      var response =
          PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "");
      response
          .then((val) => {
                setState(() {
                  if (val != null) {
                    String status = val['status'].toString();
                    String error = val['error'].toString();
                    if (status == "SUCCESS") {
                      result = "Flow Success - Status: SUCESSS";

                      Get.offAll(() => BottomNavigationBarView());
                    } else {
                      result = "Flow Success - Status: $status and $error";
                    }
                  } else {
                    result = "Incomplete Flow Error";
                  }
                })
              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }
}

class RatingQuantityMrp extends StatelessWidget {
  final int index;
  const RatingQuantityMrp({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // CartController cartController = Get.find<CartController>();
    return GetBuilder<CartController>(builder: (controller) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Rating(),
              SmallText(
                text: "MRP: ₹ ${controller.cartItems[index].price}",
                size: 13.h,
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Center(
              child: Text(
                "Qty. ${controller.cartItems[index].quantity ?? 0}",
              ),
            ),
          ),
        ],
      );
    });
  }
}
