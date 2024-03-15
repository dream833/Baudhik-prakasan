import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DetailsPageShimmer extends StatelessWidget {
  const DetailsPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.h),
              Container(
                height: 65,
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(right: 10,),
                  itemBuilder: (context, index){
                    return Container(
                      width: 110,
                      height: 55.0,
                      margin: EdgeInsets.only(top: 10, left: 10,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemContainer(height: 30.h, width: 180.w,),
                    ItemContainer(height: 30.h, width: 120.w,),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              ListView(
                primary: false,
                shrinkWrap: true,
                children: [
                  CompletedShimmerEffect(),
                  CompletedShimmerEffect(),
                  CompletedShimmerEffect(),
                  CompletedShimmerEffect(),
                  CompletedShimmerEffect(),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color color;
  final double leftMargin;
  final double rightMargin;
  const ItemContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 10,
    this.color = Colors.white,
    this.leftMargin = 10,
    this.rightMargin = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
    );
  }
}

class CompletedShimmerEffect extends StatelessWidget {
  const CompletedShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemContainer(height: 180.h, width: 150.w,),
              SizedBox(height: 8.h,),
              ItemContainer(height: 30.h, width: 120.w,)
            ],
          );
        },
      ),
    );
  }
}


