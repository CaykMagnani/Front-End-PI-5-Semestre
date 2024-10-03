import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/mock_data.dart';

class FlightProvider extends ChangeNotifier {
  String _departure = '';
  String _arrival = '';
  Map<String, dynamic>? _flightData;
  final List<Map<String, dynamic>> _flightHistory = [];

  String get departure => _departure;
  String get arrival => _arrival;
  Map<String, dynamic>? get flightData => _flightData;
  List<Map<String, dynamic>> get flightHistory => _flightHistory;

  void setDeparture(String value) {
    _departure = value;
    notifyListeners();
  }

  void setArrival(String value) {
    _arrival = value;
    notifyListeners();
  }

  Future<void> fetchFlightData() async {
    await Future.delayed(Duration(seconds: 2));
    _flightData = mockFlightData;

    // Adicionar ao histórico
    _flightHistory.add({
      'flightNumber': _flightData!['flightNumber'],
      'departure': _departure,
      'arrival': _arrival,
      'status': _flightData!['status'],
    });
    
    notifyListeners();
  }
}
