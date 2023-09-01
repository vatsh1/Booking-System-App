part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final String userName;
  final String password;

  RegisterUser(this.userName, this.password);
}
