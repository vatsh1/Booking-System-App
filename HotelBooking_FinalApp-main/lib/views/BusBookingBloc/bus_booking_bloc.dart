import 'package:bloc/bloc.dart';
import 'package:booking_app/views/BusBookingBloc/bus_booking_event.dart';
import 'package:booking_app/views/BusBookingBloc/bus_booking_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/local_storage.dart';
import '../../../data/repository/booking_repository.dart';

class BusBookingBloc extends Bloc<BusBookingEvent, BusBookingState> {
  final BookingRepository bookingRepository;
  BusBookingBloc(this.bookingRepository) : super(BusBookingInitial()) {
    on<BusBookingEvent>((event, emit) async {
      if (event is SubmitForm) {
        if (event.name.isEmpty ||
            event.busId.isEmpty ||
            event.userName.isEmpty) {
          emit(FormFailure());
        } else {
          emit(FormLoading());
          var userResponse = await bookingRepository.bookBus(
              event.userName, event.name, event.busId);
          debugPrint('Success ${userResponse.username}');
          await CacheNetwork.insertToCache(
              key: 'username', value: userResponse.username!);
          emit(FormLoaded(userResponse.username ?? ''));
        }
      } else {
        debugPrint('failed to book');
        emit(FormFailure());
      }
    });
  }
}
