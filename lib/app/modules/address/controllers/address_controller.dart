import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssgc/app/model/address.dart';

import '../../../api/base_client.dart';
import '../../../widgets/custom_message.dart';
import '../views/show_address_view.dart';

class AddressController extends GetxController {
  final addressList = [].obs;
  final isAddressLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final count = 0.obs;

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final postCodeController = TextEditingController();
  final areaController = TextEditingController();

  final landMarkController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final stateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final postCodeFocusNode = FocusNode();
  final areaFocusNode = FocusNode();

  final landMarkFocusNode = FocusNode();
  final addressLine1FocusNode = FocusNode();
  final addressLine2FocusNode = FocusNode();

  final TextEditingController updateStateController = TextEditingController();
  final TextEditingController updateCityController = TextEditingController();
  final TextEditingController updatePostalCodeController =
      TextEditingController();
  final TextEditingController updateAreaController = TextEditingController();
  final TextEditingController updateLandMarkController =
      TextEditingController();
  final TextEditingController updateAddressLine1Controller =
      TextEditingController();
  final TextEditingController updateAddressLine2Controller =
      TextEditingController();

  var isSwitched = true.obs;
  RxString switchValue = "1".obs;

  final isLoading = false.obs;
  final isUpdateAddressLoading = false.obs;
  var username = ''.obs;
  final isEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAddress();
    getUserData();
    setAddressInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  checkIsEdit() {}

  setAddressInfo() {}

  void increment() => count.value++;

  void updateSwitchValue(bool value) {
    isSwitched.value = value;
    switchValue.value = value ? "1" : "0";
    print('Switch Value: ${switchValue.value}');
  }

  getAddress() async {
    try {
      isAddressLoading.value = true;
      final response = await ApiBaseClient().getAddress();
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final cartModel = AddressModel.fromJson(jsonResponse);
        // final data = jsonResponse["data"];
        // print(data);
        // addressList.add(data);
        addressList.clear();
        List tempList = addressList.toList();

        tempList.addAll(cartModel.data!);

        tempList = tempList.reversed.toList();

        // Convert the reversed list back to an observable list
        addressList.value = tempList;

        // addressList.addAll(cartModel.data!); // Add the parsed cart items to the list
        // addressList = addressList.reversed.toList();
        isAddressLoading.value = false;
      } else {
        isAddressLoading.value = false;
        print(response.statusCode);
      }
    } catch (e) {
      print("Error is  ${e.toString()}");
      isAddressLoading.value = false;
    }
  }

  addAddress() async {
    try {
      isLoading.value = true;
      var map = <dynamic, dynamic>{};
      map['city'] = cityController.text;
      map['state'] = stateController.text;
      map['area'] = areaController.text.toString();
      map['landmark'] = landMarkController.text.toString();
      map['postal_code'] = postCodeController.text.toString();
      map['address_line1'] = addressLine1Controller.text.toString();
      map['address_line2'] = addressLine2Controller.text.toString();
      map['is_delivery'] = "1";
      final response = await ApiBaseClient().addAddress(map);
      if (response.statusCode == 201) {
        CustomMessage.successToast("Address Added successfully");
        // cityController.text = "";
        // stateController.text = "";
        // areaController.text = "";
        // landMarkController.text = "";
        // postCodeController.text = "";
        // addressLine1Controller.text = "";
        // addressLine2Controller.text = "";
        isLoading.value = false;
        update();
      } else if (response.statusCode == 401) {
        // CustomMessage.errorToast('${responseData['message']}');
        // print('${responseData['message']}');
        print("Status Code 401");
        isLoading.value = false;
        update();
      } else {
        print("Status code ${response.statusCode}");
        CustomMessage.errorToast("Can not add to cart");
        isLoading.value = false;
        update();
      }
    } catch (e) {
      print("Error is ---------------------> ${e.toString()}");
      isLoading.value = false;
      update();
    }
  }

  updateAddress(int id, int userId) async {
    try {
      isUpdateAddressLoading.value = true;
      var data = {
        'id': id,
        'user_id': userId,
        'city': updateCityController.text,
        'state': updateStateController.text,
        'area': updateAreaController.text,
        'landmark': updateLandMarkController.text,
        'postal_code': updatePostalCodeController.text,
        'address_line1': updateAddressLine1Controller.text,
        'address_line2': updateAddressLine2Controller.text,
        'is_delivery': switchValue.value.toString(),
      };
      print("my data is $data");
      final response = await ApiBaseClient().updateAddress(data);
      if (response.statusCode == 200) {
        CustomMessage.successToast("Address Updated");
        // Get.offAll(ShowAddressView());
        isUpdateAddressLoading.value = false;
      } else if (response.statusCode == 401) {
        isUpdateAddressLoading.value = false;
      } else {
        isUpdateAddressLoading.value = false;
        print("Status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      isUpdateAddressLoading.value = false;
    }
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    username.value = name!;
  }

  deleteAddress(int index, int id) async {
    final response = await ApiBaseClient().deleteAddress(id);
    Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      CustomMessage.successToast("Delete address");
      addressList.removeAt(index);
      update();
    } else if (response.statusCode == 401) {
      print('${responseData['message']}');
    }
  }

  Future<void> navigateToSavedAddressPage(BuildContext context) async {
    final addressController = Get.find<AddressController>();
    final route = MaterialPageRoute(
      builder: (context) => const ShowAddressView(),
    );
    await Navigator.push(context, route);
  }
}
