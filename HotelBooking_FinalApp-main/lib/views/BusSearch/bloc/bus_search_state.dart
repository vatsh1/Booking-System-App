part of 'bus_search_bloc.dart';

@immutable
abstract class BusSearchState {}

class BusInitial extends BusSearchState {}

class BusLoading extends BusSearchState {}

class BusNav extends BusSearchState {}

class SearchLoading extends BusSearchState {}

class SearchFailure extends BusSearchState {}

class NotFound extends BusSearchState {}

class SearchLoaded extends BusSearchState {
  final List<BusModel> busResponse;
  SearchLoaded({required this.busResponse});
  @override
  List<Object?> get props => [];
}

class FilterBusSuccessState extends BusSearchState {}
