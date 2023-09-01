part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String username;
  RegisterSuccess(
    this.username,
  );
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});
}

class RegisterLoading extends RegisterState {}
