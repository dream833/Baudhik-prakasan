import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/rating.dart';
import 'package:ssgc/app/widgets/text.dart';

import '../data/app_image.dart';

class Reviews extends StatelessWidget {
  final String name;
  final String comment;
  final double rating;
  const Reviews(
      {super.key, this.name = '', this.comment = '', this.rating = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                backgroundImage: AssetImage(AppImage.person),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Rating(
                    rating: rating,
                  ),
                  SmallText(
                    text: name,
                    size: 15,
                  ),
                  SmallText(
                    text: comment,
                    size: 13,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              SmallText(
                text: "Sept 04, 2023",
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
