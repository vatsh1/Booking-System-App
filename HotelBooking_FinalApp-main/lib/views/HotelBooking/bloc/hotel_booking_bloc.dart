import 'package:bloc/bloc.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_event.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/local_storage.dart';
import '../../../data/repository/booking_repository.dart';

class HotelBookingBloc extends Bloc<HotelBookingEvent, HotelBookingState> {
  final BookingRepository bookingRepository;
  HotelBookingBloc(this.bookingRepository) : super(HotelBookingInitial()) {
    on<HotelBookingEvent>((event, emit) async {
      if (event is SubmitForm) {
        if (event.name.isEmpty || event.username.isEmpty) {
          emit(FormFailure());
        } else {
          emit(FormLoading());
          var userResponse = await bookingRepository.bookHotel(
              event.username,
              event.name,
              event.typeId,
              event.typeName,
              event.seatNo,
              event.location,
              event.date,
              event.phNumber,
              event.type,
              event.price);
          debugPrint('Success ${userResponse.username}');
          await CacheNetwork.insertToCache(
              key: 'username', value: userResponse.username!);
          emit(FormLoaded(userResponse.username ?? '', userResponse));
        }
      } else {
        debugPrint('failed to login');
        emit(FormFailure());
      }
    });
  }
}
