import 'dart:ffi';

class BookingModel {
  int? bookingId;
  String? username;
  String? name;
  int? typeId;
  String? typeName;
  String? seatNo;
  String? location;
  String? toCity;
  String? fromCity;
  String? date;
  String? phNumber;
  String? type;
  double? price;
  String? bookingStatus;

  // Constructor
  BookingModel(
      this.bookingId,
      this.username,
      this.name,
      this.typeId,
      this.typeName,
      this.seatNo,
      this.location,
      this.toCity,
      this.fromCity,
      this.date,
      this.phNumber,
      this.type,
      this.price,
      this.bookingStatus);

  // Named constructor
  BookingModel.fromJson({required Map<String, dynamic> data}) {
    bookingId = data['bookingId'];
    // Refactoring Map | Json
    username = data['username'];

    name = data['name'];

    typeId = data['typeId'];

    typeName = data['typeName'];

    seatNo = data['seatNo'];

    location = data['location'];

    toCity = data['toCity'];

    fromCity = data['fromCity'];

    date = data['date'];

    phNumber = data['phNumber'];

    type = data['type'];

    price = data['price'];

    bookingStatus = data['bookingStatus'];
  }
}
