import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';

class FlightHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Voos'),
      ),
      body: Center(
        child: flightProvider.flightData == null
            ? Text('Nenhum voo registrado.')
            : ListView(
                children: [
                  ListTile(
                    title: Text('Voo: ${flightProvider.flightData!['flightNumber']}'),
                    subtitle: Text(
                      'Partida: ${flightProvider.flightData!['departure']} \n'
                      'Chegada: ${flightProvider.flightData!['arrival']} \n'
                      'Status: ${flightProvider.flightData!['status']}',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
