import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importando para formatação de data

class FlightDetailView extends StatelessWidget {
  final Map<String, dynamic> flightData;

  FlightDetailView({required this.flightData});

  @override
  Widget build(BuildContext context) {
    // Função para formatar data e hora
    String formatDateTime(String? dateTime) {
      if (dateTime == null || dateTime.isEmpty) return 'N/A';
      try {
        final parsedDate = DateTime.parse(dateTime);
        return DateFormat('dd/MM/yyyy HH:mm').format(parsedDate); // Formatação no formato português
      } catch (e) {
        print("Erro ao formatar data: $e");
        return 'N/A';
      }
    }

    // Função para calcular a duração em horas e minutos
    String formatDuration(int? durationInMinutes) {
      if (durationInMinutes == null || durationInMinutes <= 0) return 'N/A';

      int hours = durationInMinutes ~/ 60; // Divisão inteira para horas
      int minutes = durationInMinutes % 60; // Resto da divisão para minutos

      return '$hours hora${hours != 1 ? 's' : ''} e $minutes minuto${minutes != 1 ? 's' : ''}';
    }

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
            Text('Data da Partida: ${formatDateTime(flightData['departureTime'])}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Data da Chegada: ${formatDateTime(flightData['arrivalTime'])}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Duração: ${formatDuration(flightData['duration'])}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
