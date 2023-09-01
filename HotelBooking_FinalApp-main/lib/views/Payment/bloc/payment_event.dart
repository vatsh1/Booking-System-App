abstract class PaymentEvent {}

class SubmitForm extends PaymentEvent {
  final int? bookingId;
  final String? email;
  final double? price;
  final String cardNumber;
  final String nameOnCard;
  final String expiryDate;
  final String cvv;

  SubmitForm(
      {required this.bookingId,
      required this.email,
      required this.price,
      required this.cardNumber,
      required this.nameOnCard,
      required this.expiryDate,
      required this.cvv});
}
