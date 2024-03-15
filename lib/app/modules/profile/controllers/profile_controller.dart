import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/globals.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/custom_message.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final studyTimeController = TextEditingController();
  final referralCodeController = TextEditingController();

  final name = ''.obs;
  final token = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final id = 0.obs;
  final isLoading = false.obs;
  final isProfileUpdateLoading = false.obs;
  final imagePath = ''.obs;

  XFile? profilePic;
  final ImagePicker picker = ImagePicker();

  var selectedTime = TimeOfDay.now().obs;

  void updateTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void pickImageFromGallery() async {
    print("xxxxxxxxxxxxxxx");
    XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if (image != null) {
      profilePic = image;
      update();
      print("aaaaaaaaaaaaaaa");
      // uploadProfilePic();
    }
  }

  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      imagePath.value = image.path.toString();
    }
  }

  getUserData() async {
    isLoading.value = true;
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      name.value = sp.getString('name') ?? ''; // Provide a default value if null
      token.value = sp.getString('token') ?? '';
      phone.value = sp.getString('phone') ?? '';
      email.value = sp.getString('email') ?? '';
      id.value = sp.getInt('id')!;
      isLoading.value = false;
      if (nameController.text.isEmpty) {
        nameController.text = name.value;
      }
      if (emailController.text.isEmpty) {
        emailController.text = email.value; // Set it to an empty string or provide a default value if needed
      }
      if (phoneController.text.isEmpty) {
        phoneController.text = phone.value;
      }

      nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length),
      );
      phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length),
      );

    } catch(e){
      isLoading.value = false;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null) {
      updateTime(picked);
      printSelectedTime();
    }
  }

  void printSelectedTime() {
    final formattedTime = DateFormat.Hm().format(
      DateTime(2021, 1, 1, selectedTime.value.hour, selectedTime.value.minute),
    );
    print('Selected Time: $formattedTime');
  }

  updateUser() async {
    isProfileUpdateLoading.value = true;
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final token = sp.getString('token');

      final now = DateTime.now();
      final formattedDate = "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";
      final fileName = "image_$formattedDate.jpg";
      // final fileName = generateFileNameWithDateTime();
      final uri = Uri.parse('${UtilGlobals.baseUrl}/user-profile.php');
      final request = http.MultipartRequest('POST', uri)
        ..fields['phone'] = phoneController.text
        ..fields['name'] = nameController.text
        ..fields['email'] = emailController.text
        ..headers['token'] = token!;
        // ..files.add(await http.MultipartFile.fromPath('photo', profilePic!.path));
        // ..files.add(await http.MultipartFile.fromPath('photo', imagePath.value));
        // ..files.add(http.MultipartFile(
        //   'photo',
        //   File(imagePath.value).readAsBytes().asStream(),
        //   File(imagePath.value).lengthSync(),
        //   filename: fileName,
        // ));

      print(token);

      // if (imagePath.value.isNotEmpty) {
      //   request.files.add(http.MultipartFile(
      //     'photo',
      //     File(imagePath.value).readAsBytes().asStream(),
      //     File(imagePath.value).lengthSync(),
      //     filename: fileName,
      //   ));
      // }

      print(imagePath.toString());

      // request.headers['token'] = token!;

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        CustomMessage.successToast("Profile Updated successful");
        print('Response: //////////////////////////// ${response.body}');
        sp.setString('name', nameController.text);
        sp.setString('email', emailController.text);
        sp.setString('phone', phoneController.text);
        isProfileUpdateLoading.value = false;
        update();
      } else {
        CustomMessage.errorToast("Profile Update Failed");
        print('Response: ${response.body}');
        isProfileUpdateLoading.value = false;
        update();
      }


    }catch(e){
      isProfileUpdateLoading.value = false;
      print("Error is ----------> ${e.toString()}");
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
