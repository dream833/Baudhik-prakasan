import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/aboutus/views/about_us.dart';
import 'package:ssgc/app/modules/customer_support/views/customer_support_view.dart';
import 'package:ssgc/app/modules/login/views/login_view.dart';
import 'package:ssgc/app/modules/my_orders/views/my_orders_view.dart';
import 'package:ssgc/app/modules/profile/controllers/profile_controller.dart';
import 'package:ssgc/app/modules/profile/views/profile_view.dart';
import 'package:ssgc/app/modules/wishlist/views/wishlist_view.dart';
import 'package:ssgc/app/screens/terms_and_condition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/app_image.dart';
import '../../../widgets/account_items.dart';
import '../../../widgets/app_color.dart';
import '../../../widgets/text.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    final profileController = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  // Profile section start here
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BigText(
                                text: profileController.name.value.isEmpty
                                    ? "Hi, Guest"
                                    : profileController.name.value.toString(),
                                size: 17,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SmallText(
                              text: profileController.token.value.isEmpty
                                  ? "please login ro enjoy your shopping"
                                  : profileController.phone.value,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          backgroundImage: AssetImage(AppImage.person),
                        ),
                      ],
                    ),
                  ),

                  // Profile section end here
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? token = await controller.getToken();
                      if (token == null || token.isEmpty) {
                        print("Token is empty");
                      } else {
                        print("Token found");
                        Get.to(() => ProfileView());
                      }
                    },
                    child: const AccountItems(
                      icon: Icons.person_2_outlined,
                      title: "Profile",
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => MembershipView());
                  //   },
                  //   child: const AccountItems(
                  //     icon: Icons.card_membership,
                  //     title: "Membership",
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MyOrdersView());
                    },
                    child: const AccountItems(
                        icon: Icons.local_mall_outlined, title: "My Orders"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const WishlistView());
                    },
                    child: const AccountItems(
                        icon: Icons.favorite_border_outlined,
                        title: "Wishlist"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CustomerSupportView());
                    },
                    child: const AccountItems(
                      icon: Icons.support_agent_outlined,
                      title: "Customer Support",
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => EarnAccountsView());
                  //   },
                  //   child: const AccountItems(
                  //       icon: Icons.badge_outlined, title: "Earn Accounts"),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => ReferAndEarnView());
                  //   },
                  //   child: const AccountItems(
                  //       icon: Icons.military_tech_outlined,
                  //       title: "Refer & Get Points"),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // cehckUserLoggedIn();
                      controller.isUserLoggedIn(context);
                      // Get.to(() => ChangePasswordView());
                    },
                    child: const AccountItems(
                      icon: Icons.lock_reset_outlined,
                      title: "Change Password",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AboutUs());
                    },
                    child: const AccountItems(
                      icon: Icons.info_outline,
                      title: "About Us",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const TermsAndCondition());
                    },
                    child: const AccountItems(
                      icon: Icons.help_outline,
                      title: "Terms & Conditions",
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      var url =
                          "https://baudhikprakashanparikshavani.in/refund.html";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                    child: const AccountItems(
                      icon: Icons.help_outline,
                      title: "Refund",
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      var url =
                          "https://baudhikprakashanparikshavani.in/return.html";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                    child: const AccountItems(
                      icon: Icons.help_outline,
                      title: "Return",
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      profileController.token.value.isNotEmpty
                          ? showExitPopup(context, controller)
                          : Get.offAll(
                              () => LoginView(),
                            );
                    },
                    child: AccountItems(
                      icon: profileController.token.value.isNotEmpty
                          ? Icons.logout_outlined
                          : Icons.login,
                      title: profileController.token.value.isNotEmpty
                          ? "Logout"
                          : "Login",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

showExitPopup(context, controller) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Do you want to Logout?"),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // exit(0);
                          controller.removeUser();
                          Navigator.of(context).pop();
                          Get.offAll(() => LoginView());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mainColor),
                        child: const Text("Yes"),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.buttoncolor,
                      ),
                      child: const Text("No",
                          style: TextStyle(color: Colors.white)),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
