import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutBodyShimmer extends StatelessWidget {
  const CheckoutBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyShimmer(),
              BodyShimmer(),
              BodyShimmer(),

              SizedBox(height: 8.h,),

              Container(
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                height: 110.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                height: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h,),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyShimmer extends StatelessWidget {
  const BodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 8.w, right: 10.w, bottom: 5.h,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 105.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 23.h,
                  // width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 22.h,
                        // width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Container(
                      height: 22.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h,),
                Container(
                  height: 20.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h,),
                Container(
                  height: 20.h,
                  // width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


