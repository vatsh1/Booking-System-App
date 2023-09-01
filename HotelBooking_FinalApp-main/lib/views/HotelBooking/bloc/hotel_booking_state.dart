import 'package:booking_app/data/model/booking_model.dart';

abstract class HotelBookingState {}

class HotelBookingInitial extends HotelBookingState {}

class FormLoading extends HotelBookingState {}

class FormLoaded extends HotelBookingState {
  final String username;
  BookingModel bookingModel;
  FormLoaded(this.username, this.bookingModel);
}

class FormFailure extends HotelBookingState {}

class EmptyFields extends HotelBookingState {}
