import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:ssgc/app/modules/login/controllers/login_controller.dart';
import 'package:telephony/telephony.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../bottom_navigation_bar/views/bottom_navigation_bar_view.dart';

class OTPViewPage extends StatefulWidget {
  const OTPViewPage({super.key});

  @override
  State<OTPViewPage> createState() => _OTPViewPageState();
}

class _OTPViewPageState extends State<OTPViewPage> {
  late CountdownController countdownController;
  int counterTime = (60 * 2);
  bool counterFinished = false;
  bool buttonEnabled = false;
  bool isloading_otp = false;
  String Val = "";
  bool show_btn = false;
  bool count_length = false;
  String? appSignature;
  final _formKey = GlobalKey<FormState>(debugLabel: 'Subscription Form');
  bool isLoading = false;
  TextEditingController phoneController = TextEditingController();
  final loginController = Get.put(LoginController());

  String otp = '';

  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();

  @override
  void initState() {
    super.initState();
    countdownController = CountdownController(autoStart: true);
//    final signcode = SmsAutoFill().getAppSignature;
    // _litsenotp();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        debugPrint(message.address);
        debugPrint(message.body);

        String sms = message.body.toString();

        if (message.body!.contains(
            'is your OTP for login bharat consultancy web portal. suraj shukla')) {
          String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
          otpbox.set(otpcode.split(""));

          setState(() {
            //verifysubOTP(phone: widget.phone, otp: int.parse(otp));
          });
        } else {
          debugPrint("error");
        }
      },
      listenInBackground: false,
    );
  }

  changeRoute() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(BottomNavigationBarView());
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 30),
              const Text(
                "Confirmation",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "We will send a confirmation to your phone number",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Countdown(
                    build: (BuildContext context, double time) => Center(
                      child: Text(
                        '${time ~/ 60}:${(time % 60).toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    seconds: counterTime,
                    interval: const Duration(
                      seconds: 1,
                    ),
                    controller: countdownController,
                    onFinished: () {
                      setState(() {
                        counterFinished = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'Min',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              OTPTextField(
                onChanged: (pin) {
                  otp = pin;
                  debugPrint('onCompleted: $pin ');
                  try {
                    loginController.loginUser();
                    changeRoute();

                    debugPrint('verification successful');
                  } catch (ex) {
                    debugPrint(ex.toString());
                  }
                },
                outlineBorderRadius: 10,
                controller: otpbox,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  otp = pin;

                  debugPrint('onCompleted: $pin ');
                  try {
                    loginController.loginUser();
                    changeRoute();

                    debugPrint('verification successful');
                  } catch (ex) {
                    debugPrint(ex.toString());
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (counterFinished) {
                      countdownController.restart();
                      setState(() {
                        counterFinished = false;
                      });
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      'Resend OTP',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void verify() {}
}
