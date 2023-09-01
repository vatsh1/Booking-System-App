import 'package:booking_app/data/local_storage.dart';
import 'package:booking_app/data/model/hotel_model.dart';
import 'package:booking_app/data/repository/booking_repository.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_bloc.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_event.dart';
import 'package:booking_app/views/HotelBooking/bloc/hotel_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelBookingScreen extends StatelessWidget {
  HotelBookingScreen({
    Key? key,
    required this.hotelModel,
  }) : super(key: key);

  final HotelModel hotelModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel Booking form',
        ),
      ),
      body: BlocConsumer<HotelBookingBloc, HotelBookingState>(
        listener: (context, state) {
          if (state is FormLoaded) {
            Navigator.of(context)
                .pushNamed('/payment', arguments: state.bookingModel);
          } //else if (state is NotFound) {
          //   showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text("Oops"),
          //           titleTextStyle: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black,
          //               fontSize: 20),
          //           actionsOverflowButtonSpacing: 20,
          //           actions: [
          //             IconButton(
          //               onPressed: () {
          //                 Navigator.of(context).pushNamed('/searchFlight');
          //               },
          //               icon: const Icon(Icons.mood_bad),
          //               alignment: Alignment.center,
          //             ),
          //           ],
          //           content: const Text("No Match Found"),
          //         );
          //       });
          // }
        },
        builder: (context, state) {
          if (state is FormLoading) {
            return LoadingWidget(
              child: initialLayout(context),
            );
          } else {
            return initialLayout(context);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '    Payment Amount:    ${hotelModel.pricePerNight?.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _roomController,
              decoration: const InputDecoration(
                labelText: 'Room No',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // BlocProvider.of<FlightSearchBloc>(context)
                    //     .add(Search(_fromCity.text, _toCity.text));
                    String? username =
                        await CacheNetwork.getCacheData(key: 'username');
                    // ignore: use_build_context_synchronously
                    BlocProvider.of<HotelBookingBloc>(context).add(SubmitForm(
                        username: username!,
                        name: _nameController.text,
                        typeId: hotelModel.id,
                        typeName: '${hotelModel.name}',
                        seatNo: _roomController.text,
                        location: '${hotelModel.city}',
                        date: '${hotelModel.checkIn}',
                        phNumber: _phoneController.text,
                        type: "hotel",
                        price: hotelModel.pricePerNight));
                  },
                  child: const Text("continue for payment")),
            ),
          ],
        ),
      );
}





// class BookingFormBloc {
//   void submitBookingForm(String name, String phone) {
//     // Handle submission of booking form data
//     // ...
//   }
// }


// .add(SubmitForm(
//                         userName: username!,
//                         name: _nameController.text,
//                         typeId: '${hotelModel.id}',
//                         typeName: '${hotelModel.name}',
//                         seatNo: _roomController.text,
//                         location: '${hotelModel.city}',
//                         date: '${hotelModel.checkIn}',
//                         phNumber: _phoneController.text,
//                         type: 'hotel',
//                         price: '${hotelModel.pricePerNight}')

// abstract class BookingFormEvent {}

// class SubmitBookingFormEvent extends BookingFormEvent {
//   final String name;
//   final String phone;

//   SubmitBookingFormEvent({this.name, this.phone});
// }

// abstract class BookingFormState {}

// class BookingFormInitial extends BookingFormState {}

// class BookingFormSubmitting extends BookingFormState {}

// class BookingFormSubmitted extends BookingFormState {}
