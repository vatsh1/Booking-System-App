import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/model/booking_model.dart';
import 'package:booking_app/data/model/payment_model.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/views/OtpPage/bloc/otp_bloc.dart';
import 'package:booking_app/views/OtpPage/bloc/otp_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({
    Key? key,
    required this.paymentModel,
  }) : super(key: key);
  final PaymentModel paymentModel;
  //final BookingModel bookingModel;
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'otp',
        ),
      ),
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is FormLoaded) {
            Navigator.of(context).pushNamed('/dashboardScreen');
          } //else if (state is NotFound) {
          //   showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text("Oops"),
          //           titleTextStyle: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black,
          //               fontSize: 20),
          //           actionsOverflowButtonSpacing: 20,
          //           actions: [
          //             IconButton(
          //               onPressed: () {
          //                 Navigator.of(context).pushNamed('/searchFlight');
          //               },
          //               icon: const Icon(Icons.mood_bad),
          //               alignment: Alignment.center,
          //             ),
          //           ],
          //           content: const Text("No Match Found"),
          //         );
          //       });
          // }
        },
        builder: (context, state) {
          if (state is FormLoading) {
            return LoadingWidget(
              child: initialLayout(context),
            );
          } else {
            return initialLayout(context);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              '    email:    ${paymentModel.email}',
              style: const TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<OtpBloc>(context).add(SubmitForm(
                        email: '${paymentModel.email}',
                        otp: _otpController.text,
                        bookingId: paymentModel.bookingId,
                        cardNumber:
                            '${paymentModel.creditCardDetails?.cardNumber}',
                        price: paymentModel.price));
                  },
                  child: const Text("verify")),
            ),
          ],
        ),
      );
}
