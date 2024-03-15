import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssgc/app/modules/quize/controllers/quiz_controllers.dart';

import '../../../widgets/app_color.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuizController());
    controller.getQuiz();
    return Scaffold(
      backgroundColor: AppColor.white50,
      appBar: AppBar(
        backgroundColor: AppColor.white50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Quiz',
          style: TextStyle(
            color: AppColor.black
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColor.black,
        ),
      ),
      // body: Obx(()=> controller.isQuizLoading.value ? CircularProgressIndicator() :
      //   Column(
      //     children: [
      //       Obx(()=>
      //         controller.isCategoryLoading.value
      //             ? CircularProgressIndicator()
      //             : Text(controller.categoryList.length.toString(),
      //         ),
      //       ),
      //       FutureBuilder(
      //         future: controller.getQuiz(),
      //           builder: (context, snapshot){
      //         if (snapshot.connectionState == ConnectionState.waiting){
      //           return Text("Loading .....................");
      //         } else if (snapshot.hasError){
      //           return Text('Error to fetch data');
      //         }
      //         else {
      //           return Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text('Quize'),
      //                   Text('View ALL'),
      //                 ],
      //               ),
      //             ],
      //           );
      //         }
      //       }),
      //       Text(controller.quiz.value.quiz!.title.toString()),
      //     ],
      //   ),
      // ),
    );
  }
}

