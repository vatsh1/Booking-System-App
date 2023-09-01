import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:booking_app/data/model/bus_model.dart';
import 'package:booking_app/data/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

part 'bus_search_event.dart';
part 'bus_search_state.dart';

class BusSearchBloc extends Bloc<BusSearchEvent, BusSearchState> {
  BusSearchBloc() : super(BusInitial()) {
    on<BusSearchEvent>((event, emit) async {
      debugPrint('check Status');
      if (event is NavBack) {
        emit(BusNav());
      }
      if (event is Search) {
        debugPrint(
          'Search is done?${event.fromCity}',
        );

        if (event.fromCity.isEmpty && event.toCity.isEmpty) {
          emit(SearchFailure());
        } else {
          emit(SearchLoading());
          List<BusModel> bus = [];

          String? token = await CacheNetwork.getCacheData(key: 'token');
          debugPrint(' taking token: $token');

          Response response = await get(
              Uri.parse(
                  "http://10.0.2.2:9090/bus/search?fromCity=${event.fromCity}&toCity=${event.toCity}"),
              headers: {
                'Authorization': 'Bearer $token',
              });
          debugPrint("${response.statusCode}");
          debugPrint(response.body);
          var responseBody = jsonDecode(response.body);
          for (var item in responseBody) {
            bus.add(BusModel.fromJson(item));
          }

          // loop list
          if (response.statusCode == 200 && bus.isNotEmpty) {
            debugPrint('Bus List is: $responseBody');

            emit(SearchLoaded(busResponse: bus));
          } else {
            emit(NotFound());
            emit(SearchFailure());
          }
        }
      }
    });
  }
}
