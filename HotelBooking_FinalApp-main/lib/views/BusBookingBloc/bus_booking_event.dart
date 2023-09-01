abstract class BusBookingEvent {}

class SubmitForm extends BusBookingEvent {
  final String userName;
  final String name;
  final String busId;

  SubmitForm({required this.userName, required this.busId, required this.name});
}
