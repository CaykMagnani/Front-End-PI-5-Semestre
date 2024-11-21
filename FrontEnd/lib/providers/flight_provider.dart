import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Para mobile
//import 'dart:html' as html; // Para web

class FlightProvider extends ChangeNotifier {
  String _departure = '';
  String _arrival = '';
  Map<String, dynamic>? _flightData;
  List<Map<String, dynamic>> _flightHistory = [];

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
    _flightData = {
      'flightNumber': '12345', // Mock de dados
      'status': 'Não realizado',
      'departureTime': null,
      'arrivalTime': null,
      'duration': null,
    };

    _addToHistory();
    notifyListeners();
  }

  void _addToHistory() {
    if (_flightData != null) {
      _flightHistory.add({
        'flightNumber': _flightData!['flightNumber'],
        'departure': _departure,
        'arrival': _arrival,
        'status': _flightData!['status'],
        'departureTime': _flightData!['departureTime'],
        'arrivalTime': _flightData!['arrivalTime'],
        'duration': _flightData!['duration'],
      });
      _saveFlightHistory(); // Salvar o histórico localmente
    }
  }

  Future<void> _saveFlightHistory() async {
    if (kIsWeb) {
      //html.window.localStorage['flightHistory'] = json.encode(_flightHistory);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('flightHistory', json.encode(_flightHistory));
    }
  }

  Future<void> fetchFlightHistory() async {
    if (kIsWeb) {
      // String? historyString = html.window.localStorage['flightHistory'];
      // if (historyString != null) {
      //   List<dynamic> historyList = json.decode(historyString);
      //   _flightHistory = List<Map<String, dynamic>>.from(historyList);
      // } else {
      //   _flightHistory = []; // Caso não haja histórico
      // }
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? historyString = prefs.getString('flightHistory');
      if (historyString != null) {
        List<dynamic> historyList = json.decode(historyString);
        _flightHistory = List<Map<String, dynamic>>.from(historyList);
      } else {
        _flightHistory = []; // Caso não haja histórico
      }
    }
    notifyListeners();
  }

  void concludeFlight(int index, DateTime departureTime, DateTime arrivalTime) {
    final flight = _flightHistory[index];
    flight['departureTime'] = departureTime.toIso8601String(); // Formato ISO
    flight['arrivalTime'] = arrivalTime.toIso8601String(); // Formato ISO
    flight['duration'] = arrivalTime.difference(departureTime).inMinutes; // Duração em minutos
    flight['status'] = 'Concluído';
    
    _saveFlightHistory(); // Atualiza o histórico
    notifyListeners();
  }
}
