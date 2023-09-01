import 'package:bloc/bloc.dart';
import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/model/payment_model.dart';
import 'package:booking_app/data/repository/payment_repository.dart';
import 'package:booking_app/views/Payment/bloc/payment_event.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  PaymentBloc(this.paymentRepository) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) async {
      if (event is SubmitForm) {
        if (event.cardNumber.isEmpty) {
          emit(FormFailure());
        } else {
          emit(FormLoading());
          var userResponse = await paymentRepository.payment(
            event.bookingId,
            event.email,
            event.price,
            event.cardNumber,
            event.nameOnCard,
            event.expiryDate,
            event.cvv,
          );
          debugPrint('Success $userResponse');
          emit(FormLoaded(userResponse));
        }
      } else {
        debugPrint('failed to login');
        emit(FormFailure());
      }
    });
  }
}
