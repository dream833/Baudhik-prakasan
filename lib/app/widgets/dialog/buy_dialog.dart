import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';

class CustomAlertDialog {
  final BuildContext context;

  CustomAlertDialog(this.context);

  Future<void> show({
    Function? onConfirm,
    Function? onCancel,
  }) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h,),
              Text(
                'To access this file you need to buy this course!!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                  height: 1.2.h,
                ),
              ),
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.r),
                    color: AppColor.mainColor,
                  ),
                  child: Center(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h,),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.r),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17.h,),
            ],
          ),
        );
      },
    );
  }
}
