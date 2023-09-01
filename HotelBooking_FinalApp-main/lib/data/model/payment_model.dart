class PaymentModel {
  int? bookingId;
  String? email;
  double? price;
  CreditCardDetails? creditCardDetails;

  PaymentModel(
      {this.bookingId, this.email, this.price, this.creditCardDetails});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    email = json['email'];
    price = json['price'];
    creditCardDetails = json['creditCardDetails'] != null
        ? new CreditCardDetails.fromJson(json['creditCardDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['email'] = this.email;
    data['price'] = this.price;
    if (this.creditCardDetails != null) {
      data['creditCardDetails'] = this.creditCardDetails!.toJson();
    }
    return data;
  }
}

class CreditCardDetails {
  String? cardNumber;
  String? nameOnCard;
  String? expiryDate;
  String? cvv;

  CreditCardDetails(
      {this.cardNumber, this.nameOnCard, this.expiryDate, this.cvv});

  CreditCardDetails.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    nameOnCard = json['nameOnCard'];
    expiryDate = json['expiryDate'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNumber'] = this.cardNumber;
    data['nameOnCard'] = this.nameOnCard;
    data['expiryDate'] = this.expiryDate;
    data['cvv'] = this.cvv;
    return data;
  }
}
