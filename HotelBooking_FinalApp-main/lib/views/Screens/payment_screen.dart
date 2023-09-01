import 'package:booking_app/data/model/booking_model.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    Key? key,
    required this.bookingModel,
  }) : super(key: key);

  BookingModel bookingModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment',
          ),
        ),
        body: initialLayout(context));
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              '    BookingId:    ${bookingModel.bookingId}',
              style: const TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
          ],
        ),
      );
}
