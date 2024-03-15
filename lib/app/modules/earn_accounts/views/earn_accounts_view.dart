import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/text.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../search_screen/controllers/search_screen_controller.dart';
import '../controllers/earn_accounts_controller.dart';

// ignore: must_be_immutable
class EarnAccountsView extends GetView<EarnAccountsController> {
  ProfileController profileController = Get.put(ProfileController());
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());
  EarnAccountsView({Key? key}) : super(key: key);
  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "Earn Account"),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width / 1.6,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'Enter coupon code ',
                                hintStyle: const TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF00C9A7)))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: BigText(
                              text: "APPLY",
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SmallText(
                      text: "Balance Points : ",
                      size: 14,
                    ),
                    SmallText(
                      text: "850",
                      color: Colors.red,
                      size: 14,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
