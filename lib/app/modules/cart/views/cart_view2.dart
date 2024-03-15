import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/data/app_image.dart';
import 'package:ssgc/app/modules/checkout/views/checkout_view.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/empty_widget.dart';
import 'package:ssgc/app/widgets/image_loader.dart';
import 'package:ssgc/app/widgets/outline_button.dart';
import 'package:ssgc/app/widgets/rounded_button.dart';
import 'package:ssgc/app/widgets/vertical_divider.dart';

import '../../../widgets/rating.dart';
import '../../../widgets/text.dart';
import '../controllers/cart_controller.dart';

class CartView2 extends GetView<CartController> {
  const CartView2({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    double totalCartPrice = cartController.calculateTotalCartPrice();

    Future.delayed(const Duration(milliseconds: 500), () {
      return controller.getCart();
    });

    onRefresh() async {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.getCart();
        controller.calculateTotalCartPrice();
      });
    }

    // cartController.getCart();

    // cartController.showPageWithDelay();

    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white50,
        title: BigText(text: "My Cart"),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColor.black,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => cartController.isCartItemLoading.value
                      ? Container()
                      : cartController.cartItems.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 150.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: EmptyView(
                                  image: AssetImage(AppImage.empty_cart),
                                  mainText: "Ohh... Your Cart is Empty",
                                  subText:
                                      "Add Something To Make Me Happy  : )",
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: cartController.cartItems.length,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  itemBuilder: (context, index) {
                                    final cartItem =
                                        controller.cartItems[index];

                                    return Container(
                                      // color: Colors.red,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          // Book image and text
                                          Row(
                                            children: [
                                              /// Product Image here
                                              AppImageLoader(
                                                  imageUrl:
                                                      cartItem.image.toString(),
                                                  height: 90,
                                                  width: 75),

                                              /// Book Details start here
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Book name
                                                      SmallText(
                                                        text:
                                                            cartItem.name ?? '',
                                                        size: 14,
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),
                                                      RatingQuantityMrp(
                                                          index: index),
                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      SmallText(
                                                        text:
                                                            "Sale Price: ₹${cartItem.price ?? 0}",
                                                        size: 12.h,
                                                      ),
                                                      GetBuilder<
                                                              CartController>(
                                                          builder: (context) {
                                                        return SmallText(
                                                          text:
                                                              "Total Price: ₹${cartItem.totalPrice ?? 0}",
                                                          size: 13.h,
                                                        );
                                                      }),
                                                      // SmallText(text: "Total Price: ₹${cartItem.total_price ?? 0}", size: 12,),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          RemoveWishlistCoupon(
                                              id: cartItem.id, index: index),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            height: 1,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                Text(
                                  "Order Summary",
                                  style: TextStyle(
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                GetBuilder<CartController>(
                                    builder: (controller) {
                                  return OrderSummary(
                                    text: "Order Subtotal",
                                    amount:
                                        "₹ ${controller.calculateTotalCartPrice().toStringAsFixed(2)}",
                                  );
                                }),
                                const OrderSummary(
                                    text: "Discount On Sale", amount: "₹0.00"),
                                // OrderSummary(text: "Delivery fee", amount: "₹40.00"),
                                // OrderSummary(text: "Coin Points Discount", amount: "₹100.00"),
                                const Divider(),
                                GetBuilder<CartController>(
                                    builder: (controller) {
                                  return OrderSummary(
                                    text: "Total Amount",
                                    amount:
                                        "₹ ${controller.calculateTotalCartPrice().toStringAsFixed(2)}",
                                    fontWeight: FontWeight.bold,
                                  );
                                }),
                                const SizedBox(
                                  height: 14,
                                ),
                                const Text(
                                  "Order Info",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return OrderInfo(
                                        text:
                                            'Amount chargeable is including GST, wherever applicable',
                                        sl: '${index + 1}. ',
                                      );
                                    }),
                                const SizedBox(
                                  height: 14,
                                ),
                                GetBuilder<CartController>(
                                    builder: (controller) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: OutlineButton(
                                          onPress: () {},
                                          text:
                                              '₹ ${controller.calculateTotalCartPrice().toStringAsFixed(2)}',
                                          height: 45,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: RoundedButton(
                                          text: "CONTINUE TO CHECKOUT",
                                          isLoading: false,
                                          onPress: () {
                                            navigateToCheckoutPage(context);
                                            // Get.to(CheckoutView());
                                          },
                                          height: 45,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToCheckoutPage(BuildContext context) async {
    final cartController = Get.find<CartController>();
    final route = MaterialPageRoute(
      builder: (context) => const CheckoutView(),
    );
    await Navigator.push(context, route);
    cartController.getCart();
  }
}

class RatingQuantityMrp extends StatelessWidget {
  final int index;
  const RatingQuantityMrp({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    final cartItem = cartController.cartItems[index];

    return GetBuilder<CartController>(builder: (controller) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Rating(),
              SmallText(
                text: "MRP: ₹ ${cartItem.price ?? 0}",
                size: 11,
              ),
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColor.mainColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.decrementItemQuantity(index);
                  },
                  child: const Icon(
                    Icons.remove,
                  ),
                ),
                VerticalDivider(
                  color: AppColor.mainColor,
                  width: 2,
                ),
                Text("${controller.cartItems[index].quantity ?? 0}"),
                VerticalDivider(
                  color: AppColor.mainColor,
                  width: 2,
                ),
                GestureDetector(
                  onTap: () {
                    print("Click ${index + 1}");
                    controller.incrementItemQuantity(index);
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}

class RemoveWishlistCoupon extends StatelessWidget {
  final int id;
  final int index;
  const RemoveWishlistCoupon(
      {super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            cartController.deleteAItem(id, index);
          },
          child: const Text("Remove"),
        ),
        const CustomVerticalDivider(
          height: 24,
        ),
        const Text("Move to wishlist"),
        const CustomVerticalDivider(
          height: 24,
        ),
        const Text("Coupon"),
      ],
    );
  }
}

class OrderSummary extends StatelessWidget {
  final String text;
  final String? amount;
  final Color color;
  final FontWeight? fontWeight;
  const OrderSummary(
      {super.key,
      required this.text,
      this.amount = '',
      this.color = Colors.black,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            amount!,
            style: TextStyle(
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {
  final String sl;
  final String text;
  const OrderInfo({super.key, required this.text, required this.sl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        children: [
          Text(sl),
          const SizedBox(
            width: 5,
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
