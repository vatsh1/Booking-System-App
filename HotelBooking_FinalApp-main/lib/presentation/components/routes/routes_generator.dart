import 'package:booking_app/data/model/booking_model.dart';
import 'package:booking_app/data/model/bus_model.dart';
import 'package:booking_app/data/model/payment_model.dart';
import 'package:booking_app/data/repository/RegisterUserRepo.dart';
import 'package:booking_app/data/repository/booking_repository.dart';
import 'package:booking_app/data/repository/otp_repository.dart';
import 'package:booking_app/data/repository/payment_repository.dart';
import 'package:booking_app/data/repository/user_repository.dart';
import 'package:booking_app/views/Booking/bloc/booking_bloc.dart';
import 'package:booking_app/views/BusBookingBloc/bus_booking_bloc.dart';
import 'package:booking_app/views/BusSearch/Bus_search.dart';
import 'package:booking_app/views/BusSearch/bloc/bus_search_bloc.dart';
import 'package:booking_app/views/FlightBookingBloc/flight_booking_bloc.dart';
import 'package:booking_app/views/FlightSearch/Flight_search.dart';
import 'package:booking_app/views/FlightSearch/bloc/flight_search_bloc.dart';
import 'package:booking_app/views/HotelBooking/Hotel_Booking_Screen.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_bloc.dart';
import 'package:booking_app/views/MyBookings/bloc/myBooking_bloc.dart';
import 'package:booking_app/views/MyBookings/myBookingScreen.dart';
import 'package:booking_app/views/OtpPage/bloc/otp_bloc.dart';
import 'package:booking_app/views/OtpPage/otp_screen.dart';
import 'package:booking_app/views/Payment/bloc/payment_bloc.dart';
import 'package:booking_app/views/Payment/payment_screen.dart';

import 'package:booking_app/views/Register/bloc/register_bloc.dart';
import 'package:booking_app/views/Screens/bus_details.dart';
import 'package:booking_app/views/Screens/bus_result.dart';
import 'package:booking_app/views/Screens/dashboard_screen.dart';
import 'package:booking_app/views/Screens/flight_details.dart';
import 'package:booking_app/views/Screens/flight_result.dart';
import 'package:booking_app/views/Screens/register_screen.dart';
import 'package:booking_app/views/Screens/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking_app/views/HotelSearch/bloc/hotel_search_bloc.dart';
import 'package:booking_app/views/Login/bloc/auth_bloc.dart';
import 'package:booking_app/views/Login/login.dart';

import '../../../data/model/flight_model.dart';
import '../../../data/model/hotel_model.dart';
import '../../../views/MyBookings/bloc/bookingApi.dart';
import '../../../views/HotelSearch/hotel_search.dart';
import '../../../views/Screens/hotell_details.dart';

class RouteGenerator {
  final AuthBloc _authBloc = AuthBloc(UserRepository());
  final RegisterBloc _registerBloc = RegisterBloc(RegisterRepository());
  final HotelSearchBloc _dashboardBloc = HotelSearchBloc();
  final FlightSearchBloc _flightBloc = FlightSearchBloc();
  final BusSearchBloc _busBloc = BusSearchBloc();
  final HotelBookingBloc _bookingBloc = HotelBookingBloc(BookingRepository());
  final PaymentBloc _paymentBloc = PaymentBloc(PaymentRepository());
  final OtpBloc _otpBloc = OtpBloc(OtpRepository());
  final FlightBookingBloc _flightBookingBloc =
      FlightBookingBloc(BookingRepository());
  final BusBookingBloc _busBookingBloc = BusBookingBloc(BookingRepository());
  final BookingsBloc _myBloc = BookingsBloc(bookingApi: BookingApi());
  final BookingRepository bookingRepository = BookingRepository();
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const MyHomePage(title: "Booking App"),
          ),
        );

      case '/register':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterBloc>.value(
            value: _registerBloc,
            child: const RegisterScreen(),
          ),
        );

      case '/dashboardScreen':
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );

      case '/payment':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PaymentBloc>.value(
              value: _paymentBloc,
              child: PaymentScreen(bookingModel: args as BookingModel)),
        );

      case '/verify':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OtpBloc>.value(
              value: _otpBloc,
              child: OtpScreen(
                paymentModel: args as PaymentModel,
              )),
        );

      case '/searchHotel':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HotelSearchBloc>.value(
            value: _dashboardBloc,
            child: HotelSearchScreen(),
          ),
        );

      case '/searchFlight':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FlightSearchBloc>.value(
            value: _flightBloc,
            child: FlightSearchScreen(),
          ),
        );

      case '/searchBus':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BusSearchBloc>.value(
            value: _busBloc,
            child: BusSearchScreen(),
          ),
        );

      case '/list':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HotelSearchBloc>.value(
            value: _dashboardBloc,
            child: Result(hotelResponse: args as List<HotelModel>),
          ),
        );

      case '/flightList':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FlightSearchBloc>.value(
            value: _flightBloc,
            child: FlightResult(flightResponse: args as List<FlightModel>),
          ),
        );

      case '/busList':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BusSearchBloc>.value(
            value: _busBloc,
            child: BusResult(busResponse: args as List<BusModel>),
          ),
        );

      case '/details':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HotelBookingBloc>.value(
            value: _bookingBloc,
            child: HotelDetails(hotelModel: args as HotelModel),
          ),
        );

      case '/hotelbooking':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HotelBookingBloc>.value(
            value: _bookingBloc,
            child: HotelBookingScreen(hotelModel: args as HotelModel),
          ),
        );

      case '/flightdetails':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FlightBookingBloc>.value(
            value: _flightBookingBloc,
            child: FlightDetails(flightModel: args as FlightModel),
          ),
        );

      case '/busdetails':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BusBookingBloc>.value(
            value: _busBookingBloc,
            child: BusDetails(busModel: args as BusModel),
          ),
        );

      case '/myBookings':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BookingsBloc>.value(
            value: _myBloc,
            child: const MyBookingsScreen(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}
