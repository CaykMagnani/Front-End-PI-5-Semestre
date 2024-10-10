import 'package:flutter/material.dart';

class FlightDetailView extends StatelessWidget {
  final Map<String, dynamic> flightData;

  FlightDetailView({required this.flightData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Voo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Voo: ${flightData['flightNumber'] ?? 'N/A'}', style: TextStyle(fontSize: 24)),
            Text('Partida: ${flightData['departure'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            Text('Chegada: ${flightData['arrival'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            Text('Status: ${flightData['status'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            Text('Data da Partida: ${flightData['departureTime'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            Text('Data da Chegada: ${flightData['arrivalTime'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            Text('Duração: ${flightData['duration'] != null ? '${flightData['duration']} minutos' : 'N/A'}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
