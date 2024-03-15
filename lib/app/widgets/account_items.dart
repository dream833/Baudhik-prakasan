import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/app_color.dart';
import 'package:ssgc/app/widgets/text.dart';

class AccountItems extends StatelessWidget {
  final Color? color;
  final String title;
  final String subtitle;
  final double size;
  final double height;
  final IconData icon;
  const AccountItems({
    super.key,
    // this.color = const Color(0xFFccc7c5),
    this.color = const Color(0xFF757575),
    required this.title,
    this.subtitle = "",
    this.size = 15,
    this.height = 1.2,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColor.mainColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: title,
                    size: 14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 17,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
