import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

String environment = "SANDBOX";
String appId = "";
String merchantId = "PGTESTPAYUAT";
bool enableLogging = true;
String checksum = "";
String apiEndPoint = "/pg/v1/pay";
String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
String saltIndex = "1";
String callbackUrl =
    "https://webhook.site/55d95b9b-bec9-491e-b257-cbaf0ff7aa7e";
String body = "";
Object? result;

getChecksum() {
  final requestData = {
    "merchantId": merchantId,
    "merchantTransactionId": "transaction_123",
    "merchantUserId": "MUID123",
    "amount": 1000,
    "mobileNumber": "9999999999",
    "callbackUrl": callbackUrl,
    "paymentInstrument": {
      "type": "PAY_PAGE",
    },
  };
  String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
  checksum =
      '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
  print("checksum $checksum");
  debugPrint(result.toString());
  return base64Body;
}
