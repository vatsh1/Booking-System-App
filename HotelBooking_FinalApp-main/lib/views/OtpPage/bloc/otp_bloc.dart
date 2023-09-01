import 'package:bloc/bloc.dart';
import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/repository/otp_repository.dart';
import 'package:booking_app/views/OtpPage/bloc/otp_event.dart';
import 'package:flutter/material.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository otpRepository;
  OtpBloc(this.otpRepository) : super(OtpInitial()) {
    on<OtpEvent>((event, emit) async {
      if (event is SubmitForm) {
        if (event.otp.isEmpty) {
          emit(FormFailure());
        } else {
          emit(FormLoading());
          var userResponse = await otpRepository.verifyOtp(event.email,
              event.otp, event.bookingId, event.cardNumber, event.price);
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
