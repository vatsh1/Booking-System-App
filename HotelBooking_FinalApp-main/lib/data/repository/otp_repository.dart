import 'dart:convert';

import 'package:booking_app/data/model/booking_model.dart';
import 'package:booking_app/data/model/payment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../local_storage.dart';

class OtpRepository {
  Future<String> verifyOtp(String email, String otp, int? bookingId,
      String cardNumber, double? price) async {
    debugPrint('making request $email $otp');
    String bookingUrl =
        "http://10.0.2.2:9090/booking/verify?cardNumber=$cardNumber&price=$price&bookingId=$bookingId";
    try {
      String? token = await CacheNetwork.getCacheData(key: 'token');
      debugPrint(' taking token: $token');
      Response response = await post(
        Uri.parse(bookingUrl),
        body: json.encode({'email': email, 'otp': otp}),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Request Done${response.statusCode == 200}');

      if (response.statusCode == 200) {
        debugPrint(response.body);
        debugPrint("=============dholak chaap======");
        // final result = jsonDecode(response.body);
        // debugPrint('$result+ bhak rety');
        // debugPrint(
        //     "Booking success and  payId is : ==============$result==============");
        // debugPrint('ashish===========');

        return email;
      } else {
        debugPrint('terminate $response');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('check the fault$e');
      rethrow;
    }
  }
}
