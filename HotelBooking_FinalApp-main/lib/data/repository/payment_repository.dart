import 'dart:convert';

import 'package:booking_app/data/model/booking_model.dart';
import 'package:booking_app/data/model/payment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../local_storage.dart';

class PaymentRepository {
  String bookingUrl = "http://10.0.2.2:9090/booking/payment";
  Future<PaymentModel> payment(
    int? bookingId,
    String? email,
    double? price,
    String cardNumber,
    String nameOnCard,
    String expiryDate,
    String cvv,
  ) async {
    debugPrint('making request $bookingId $email $cardNumber $nameOnCard');

    try {
      String? token = await CacheNetwork.getCacheData(key: 'token');
      debugPrint(' taking token: $token');
      Response response = await post(
        Uri.parse(bookingUrl),
        body: json.encode({
          'bookingId': bookingId,
          'email': email,
          'price': price,
          'creditCardDetails': {
            'cardNumber': cardNumber,
            'nameOnCard': nameOnCard,
            'expiryDate': expiryDate,
            'cvv': cvv
          }
        }),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Request Done${response.statusCode == 200}');

      if (response.statusCode == 200) {
        debugPrint(response.body);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint('$result');
        debugPrint(
            "Booking success and  bookingId is : ${result['bookingId']}");

        return PaymentModel.fromJson(result);
      } else {
        debugPrint('terminate ${response.reasonPhrase}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('check the fault$e');
      rethrow;
    }
  }
}
