part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class FormLoading extends PaymentState {}

class FormLoaded extends PaymentState {
  PaymentModel paymentModel;
  FormLoaded(this.paymentModel);
}

class FormFailure extends PaymentState {}

class EmptyFields extends PaymentState {}
