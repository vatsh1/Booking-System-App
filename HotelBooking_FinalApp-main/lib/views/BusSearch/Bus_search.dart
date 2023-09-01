import 'package:booking_app/presentation/components/declarations/constants/constants.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/presentation/components/spacers.dart';
import 'package:booking_app/views/BusSearch/bloc/bus_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusSearchScreen extends StatelessWidget {
  BusSearchScreen({Key? key}) : super(key: key);
  final TextEditingController _fromCity = TextEditingController();
  final TextEditingController _toCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Buses here!',
        ),
      ),
      body: BlocConsumer<BusSearchBloc, BusSearchState>(
        listener: (context, state) {
          if (state is SearchLoaded) {
            Navigator.of(context)
                .pushNamed('/busList', arguments: state.busResponse);
          } else if (state is NotFound) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Oops"),
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    actionsOverflowButtonSpacing: 20,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/searchBus');
                        },
                        icon: const Icon(Icons.mood_bad),
                        alignment: Alignment.center,
                      ),
                    ],
                    content: const Text("No Match Found"),
                  );
                });
          }
        },
        builder: (context, state) {
          if (state is BusLoading) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _fromCity,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: kBorderRadius),
                        hintText: 'Where',
                        labelText: 'Enter your city'),
                  ),
                ),
              ],
            ),
            HeightSpacer(myHeight: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _toCity,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: kBorderRadius),
                        hintText: 'to',
                        labelText: 'Enter your city'),
                  ),
                ),
              ],
            ),
            const HeightSpacer(myHeight: 10.00),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<BusSearchBloc>(context)
                      .add(Search(_fromCity.text, _toCity.text));
                },
                child: const Text("Search")),
          ],
        ),
      );
}
