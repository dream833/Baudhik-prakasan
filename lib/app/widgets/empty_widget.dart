import 'package:flutter/material.dart';
import 'package:ssgc/app/widgets/text.dart';

class EmptyView extends StatelessWidget {
  final AssetImage image;
  final String mainText;
  final String subText;

  const EmptyView({
    super.key,
    required this.image,
    this.mainText = 'Empty',
    this.subText = 'No Data Found',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 100,
            decoration: BoxDecoration(image: DecorationImage(image: image))),
        const SizedBox(
          height: 30,
        ),
        SmallText(
          text: mainText,
          color: Colors.black54,
          size: 20,
        ),
        const SizedBox(
          height: 15,
        ),
        SmallText(
          text: subText,
          color: Colors.grey,
          size: 15,
        )
      ],
    );
  }
}
