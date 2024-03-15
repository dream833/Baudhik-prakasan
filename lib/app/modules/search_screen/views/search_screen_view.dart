import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/text.dart';
import '../controllers/search_screen_controller.dart';

// ignore: must_be_immutable
class SearchScreenView extends GetView<SearchScreenController> {
  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());
  SearchScreenView({Key? key}) : super(key: key);

  // final List<String> searchItems = [
  //   'News',
  //   'Boooks',
  //   'Ebooks',
  //   'Tests',
  //   'Videos',
  //   'Courses',
  //   'Pakages',
  // ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(text: "Search"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // search form
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 3.1,
                    child: DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.5, horizontal: 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey))),
                      hint: const Text(
                        'Select',
                        style: TextStyle(fontSize: 13),
                      ),
                      items: searchScreenController.searchItems
                          .map((item) => DropdownMenuItem<String>(
                              value: item, child: SmallText(text: item)))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select.';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: Get.width / 1.6,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Search ',
                          hintStyle: TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState!.save();
                  //     }
                  //   },
                  //   child: const Text('Submit Button'),
                  // ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(text: "Recent Search"),
                SmallText(
                  text: "Clear history",
                  color: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
