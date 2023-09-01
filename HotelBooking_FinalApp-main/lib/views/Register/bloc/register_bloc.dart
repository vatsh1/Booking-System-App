import 'package:bloc/bloc.dart';
import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/model/user_model.dart';
import 'package:booking_app/data/repository/RegisterUserRepo.dart';
import 'package:booking_app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUser) {
        if (event.userName.isEmpty || event.password.isEmpty) {
          emit(RegisterFailure(error: 'fields empty please add inputs'));
        } else {
          emit(RegisterLoading());
          try {
            var userResponse =
                await registerRepository.signUp(event.userName, event.password);
            debugPrint('Success ${userResponse.username}');
            await CacheNetwork.insertToCache(
                key: 'username', value: userResponse.username!);
            debugPrint(await CacheNetwork.getCacheData(key: 'username'));
            emit(RegisterSuccess(userResponse.username ?? ''));
          } catch (error) {
            emit(RegisterFailure(error: error.toString()));
            debugPrint('hereis s an exception ${error.toString()}');
          }
        }
      }
    });
  }
}
