import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ssgc/app/modules/login/views/login_view.dart';

import '../../../utils/globals.dart';
import '../../../widgets/custom_message.dart';
import '../../../widgets/custom_message.dart';

class RegistrationController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final isLoading = false.obs;
  final isPasswordVisible = true.obs;

  final imagePath = ''.obs;
  XFile? profilePic;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  String generateFileNameWithDateTime() {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";
    return "image_$formattedDate.jpg";
  }

  userRegistration() async {
    isLoading.value = true;
    try {
      final fileName = generateFileNameWithDateTime();
      // var map = <dynamic, dynamic>{};

      // map['photo'] = await MultipartFile.fromFile(imagePath.value);
      // map['name'] = nameController.text;
      // map['phone'] = phoneController.text;
      // map['password'] = passwordController.text.toString();
      final uri = Uri.parse('${UtilGlobals.baseUrl}/user-register.php');

      final request = http.MultipartRequest('POST', uri)
        ..fields['phone'] = "+91${phoneController.text}"
        ..fields['name'] = nameController.text
        ..fields['password'] = passwordController.text
        ..files.add(http.MultipartFile(
          'photo',
          File(imagePath.value).readAsBytes().asStream(),
          File(imagePath.value).lengthSync(),
          filename: fileName,
        ));

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // Registration successful
        print('Registration successful');
        CustomMessage.successToast("Registration successful");
        print('Response: ${response.body}');

        nameController.text = '';
        phoneController.text = '';
        passwordController.text = '';
        Get.offAll(() => LoginView());
        isLoading.value = false;
        update();
      } else {
        // Handle registration failure
        print('Registration failed');
        CustomMessage.errorToast("Registration Failed");
        print('Response: ${response.body}');
        isLoading.value = false;
        update();
      }
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
