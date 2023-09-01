part of 'otp_bloc.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class FormLoading extends OtpState {}

class FormLoaded extends OtpState {
  final String email;
  FormLoaded(this.email);
}

class FormFailure extends OtpState {}

class EmptyFields extends OtpState {}
