import 'package:booking_app/data/model/bus_model.dart';
import 'package:flutter/material.dart';

class BusResult extends StatelessWidget {
  final List<BusModel> busResponse;

  const BusResult({Key? key, required this.busResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //${hotelResponse[index].id}'

    return Scaffold(
        appBar: AppBar(
          title: const Text('Bus List'),
        ),
        body: Center(
            child: ListView.builder(
          itemCount: busResponse.length,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color.fromARGB(255, 47, 222, 187),
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/busdetails',
                                  arguments: busResponse[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus id: ${busResponse[index].busId}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Bus name: ${busResponse[index].busName}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Where: ${busResponse[index].fromCity}',
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'To : ${busResponse[index].toCity}',
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Date : ${busResponse[index].date}',
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ),
                ));
          }),
        )));
  }
}
