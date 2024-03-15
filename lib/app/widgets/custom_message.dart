import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomMessage {
  static errorToast(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static successToast(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Location where the toast message will appear
      timeInSecForIosWeb: 1, // Duration for iOS and web (in seconds)
      backgroundColor: Colors.green, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
  }

  static successSnackBar(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Location where the toast message will appear
      timeInSecForIosWeb: 1, // Duration for iOS and web (in seconds)
      backgroundColor: Colors.grey, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
  }
}