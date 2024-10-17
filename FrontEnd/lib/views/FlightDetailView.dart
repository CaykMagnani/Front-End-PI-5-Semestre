import 'package:flutter/material.dart';

class FlightDetailView extends StatelessWidget {
  final Map<String, dynamic> flightData;

  FlightDetailView({required this.flightData});

  @override
  Widget build(BuildContext context) {
    // Use as informações de partida e chegada do flightData
    final flightName = '${flightData['departure']} Até ${flightData['arrival']}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Voo', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Voo: $flightName', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Status: ${flightData['status'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Data da Partida: ${flightData['departureTime'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Data da Chegada: ${flightData['arrivalTime'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Duração: ${flightData['duration'] != null ? '${flightData['duration']} minutos' : 'N/A'}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
