import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/model/booking_model.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/views/Payment/bloc/payment_bloc.dart';
import 'package:booking_app/views/Payment/bloc/payment_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    Key? key,
    required this.bookingModel,
  }) : super(key: key);

  final BookingModel bookingModel;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card Payment',
        ),
      ),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is FormLoaded) {
            debugPrint('================');
            Navigator.of(context)
                .pushNamed('/verify', arguments: state.paymentModel);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                '    email:    ${bookingModel.username}',
                style: const TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'card holder name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'expiry date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'cvv',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<PaymentBloc>(context).add(SubmitForm(
                          bookingId: bookingModel.bookingId,
                          email: bookingModel.username,
                          price: bookingModel.price,
                          cardNumber: _cardNumberController.text,
                          nameOnCard: _nameController.text,
                          expiryDate: _expiryDateController.text,
                          cvv: _cvvController.text));
                    },
                    child: const Text("continue for payment")),
              ),
            ],
          ),
        ),
      );
}
