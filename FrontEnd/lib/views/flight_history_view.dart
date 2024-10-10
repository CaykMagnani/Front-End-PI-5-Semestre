import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import 'FlightDetailView.dart';

class FlightHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Voos'),
      ),
      body: FutureBuilder(
        future: flightProvider.fetchFlightHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (flightProvider.flightHistory.isEmpty) {
            return Center(child: Text('Nenhum voo registrado.'));
          }

          return ListView.builder(
            itemCount: flightProvider.flightHistory.length,
            itemBuilder: (context, index) {
              final flightData = flightProvider.flightHistory[index];
              final flightName = '${flightData['departure']} Até ${flightData['arrival']}';

              return ListTile(
                title: Text(flightName),
                subtitle: Text('Status: ${flightData['status']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightDetailView(flightData: flightData),
                    ),
                  );
                },
                trailing: flightData['status'] == 'Não realizado'
                    ? IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          _showConcludeFlightDialog(context, flightProvider, index);
                        },
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  void _showConcludeFlightDialog(BuildContext context, FlightProvider flightProvider, int index) {
    DateTime? departureTime;
    DateTime? arrivalTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Concluir Voo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Data e Hora da Partida (YYYY-MM-DD HH:MM)'),
                onChanged: (value) {
                  departureTime = DateTime.tryParse(value);
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Data e Hora da Chegada (YYYY-MM-DD HH:MM)'),
                onChanged: (value) {
                  arrivalTime = DateTime.tryParse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (departureTime != null && arrivalTime != null) {
                  flightProvider.concludeFlight(index, departureTime!, arrivalTime!);
                  Navigator.pop(context);
                } else {
                  // Mostrar um erro se as datas não forem válidas
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Datas inválidas!')));
                }
              },
              child: Text('Concluir'),
            ),
          ],
        );
      },
    );
  }
}
