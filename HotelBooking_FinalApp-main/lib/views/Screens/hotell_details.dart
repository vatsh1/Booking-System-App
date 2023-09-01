import 'package:booking_app/data/model/hotel_model.dart';
import 'package:booking_app/presentation/components/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local_storage.dart';
import '../../presentation/components/loader.dart';
import '../Booking/bloc/booking_bloc.dart';

class HotelDetails extends StatelessWidget {
  const HotelDetails({
    Key? key,
    required this.hotelModel,
  }) : super(key: key);

  final HotelModel hotelModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hotel Details '),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: initialLayout(context));
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Hotel id:         ${hotelModel.id}',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hotel Name:    ${hotelModel.name}',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'City :      ${hotelModel.city}',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price:     ${hotelModel.pricePerNight!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const HeightSpacer(myHeight: 10),
                  Center(
                      child: ElevatedButton(
                    child: const Text(
                      'Click to Book',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      String? username =
                          await CacheNetwork.getCacheData(key: 'username');
                      // ignore: use_build_context_synchronously
                      Navigator.of(context)
                          .pushNamed('/hotelbooking', arguments: hotelModel);
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      );
}
