abstract class OtpEvent {}

class SubmitForm extends OtpEvent {
  final String email;
  final String otp;
  final int? bookingId;
  final String cardNumber;
  final double? price;

  SubmitForm({
    required this.email,
    required this.otp,
    required this.bookingId,
    required this.cardNumber,
    required this.price,
  });
}
