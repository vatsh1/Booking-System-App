import 'package:booking_app/data/model/flight_model.dart';
import 'package:booking_app/presentation/components/spacers.dart';
import 'package:booking_app/views/FlightBookingBloc/flight_booking_bloc.dart';
import 'package:booking_app/views/FlightBookingBloc/flight_booking_event.dart';
import 'package:booking_app/views/FlightBookingBloc/flight_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local_storage.dart';
import '../../presentation/components/loader.dart';

class FlightDetails extends StatelessWidget {
  const FlightDetails({
    Key? key,
    required this.flightModel,
  }) : super(key: key);

  final FlightModel flightModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flight Details '),
        ),
        body: BlocConsumer<FlightBookingBloc, FlightBookingState>(
          listener: (context, state) {
            if (state is FormLoaded) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Success"),
                      titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                      actionsOverflowButtonSpacing: 20,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/dashboardScreen');
                          },
                          icon: const Icon(Icons.home),
                          alignment: Alignment.center,
                        ),
                      ],
                      content: const Text("Booking Successful"),
                    );
                  });
            }
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
        ));
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 00, vertical: 150),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flight id:        ${flightModel.flightId}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const HeightSpacer(myHeight: 10),
                  Text(
                    'Flight Name:  ${flightModel.flightName}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Where :       ${flightModel.fromCity}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'To :  ${flightModel.toCity}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Date :  ${flightModel.date}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const HeightSpacer(myHeight: 10),
                  Center(
                      child: ElevatedButton(
                    child: const Text('Click to Book Flight'),
                    onPressed: () async {
                      String? username =
                          await CacheNetwork.getCacheData(key: 'username');

                      BlocProvider.of<FlightBookingBloc>(context).add(
                          SubmitForm(
                              flightId: '${flightModel.flightId}',
                              name: '${flightModel.flightName}',
                              userName: username!));
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      );
}
