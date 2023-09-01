abstract class HotelBookingEvent {}

class SubmitForm extends HotelBookingEvent {
  final String username;
  final String name;
  final int? typeId;
  final String typeName;
  final String seatNo;
  final String location;
  final String date;
  final String phNumber;
  final String type;
  final double? price;

  SubmitForm(
      {required this.username,
      required this.name,
      required this.typeId,
      required this.typeName,
      required this.seatNo,
      required this.location,
      required this.date,
      required this.phNumber,
      required this.type,
      required this.price});
}
