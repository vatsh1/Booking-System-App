import 'dart:convert';

import 'package:booking_app/data/model/booking_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../local_storage.dart';

class BookingRepository {
  String bookingUrl = "http://10.0.2.2:9090/booking/";
  Future<BookingModel> bookHotel(
      String username,
      String name,
      int? typeId,
      String typeName,
      String seatNo,
      String location,
      String date,
      String phNumber,
      String type,
      double? price) async {
    debugPrint('making request $username $name $typeId $typeName');

    try {
      String? token = await CacheNetwork.getCacheData(key: 'token');
      debugPrint(' taking token: $token');
      Response response = await post(
        Uri.parse(bookingUrl),
        body: json.encode({
          'username': username,
          'name': name,
          'typeId': typeId,
          'typeName': typeName,
          'seatNo': seatNo,
          'location': location,
          'date': date,
          'phNumber': phNumber,
          'type': type,
          'price': price
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

        return BookingModel.fromJson(data: result);
      } else {
        debugPrint('terminate ${response.reasonPhrase}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('check the fault$e');
      rethrow;
    }
  }

  Future<BookingModel> bookFlight(
      String username, String name, String flightId) async {
    debugPrint('making request $username $name $flightId');

    try {
      String? token = await CacheNetwork.getCacheData(key: 'token');
      debugPrint(' taking token: $token');
      Response response = await post(
        Uri.parse(bookingUrl),
        body: json
            .encode({'username': username, 'name': name, 'flightId': flightId}),
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
        debugPrint("Booking success and  username is : ${result['username']}");

        return BookingModel.fromJson(data: result);
      } else {
        debugPrint('terminate ${response.reasonPhrase}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('check the fault$e');
      rethrow;
    }
  }

  Future<BookingModel> bookBus(
      String username, String name, String busId) async {
    debugPrint('making request $username $name $busId');

    try {
      String? token = await CacheNetwork.getCacheData(key: 'token');
      debugPrint(' taking token: $token');
      Response response = await post(
        Uri.parse(bookingUrl),
        body: json.encode({'username': username, 'name': name, 'busId': busId}),
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
        debugPrint("Booking success and  username is : ${result['username']}");

        return BookingModel.fromJson(data: result);
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
