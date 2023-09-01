part of 'bus_search_bloc.dart';

abstract class BusSearchEvent {}

class NavBack extends BusSearchEvent {}

class Search extends BusSearchEvent {
  late final String fromCity;
  late final String toCity;

  Search(this.fromCity, this.toCity);
}
