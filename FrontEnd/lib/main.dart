import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/flight_provider.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlightProvider(),
      child: MaterialApp(
        title: 'AirWise',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      ),
    );
  }
}
