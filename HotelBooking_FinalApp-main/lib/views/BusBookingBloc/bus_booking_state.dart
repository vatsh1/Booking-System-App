abstract class BusBookingState {}

class BusBookingInitial extends BusBookingState {}

class FormLoading extends BusBookingState {}

class FormLoaded extends BusBookingState {
  final String username;
  FormLoaded(this.username);
}

class FormFailure extends BusBookingState {}

class EmptyFields extends BusBookingState {}
