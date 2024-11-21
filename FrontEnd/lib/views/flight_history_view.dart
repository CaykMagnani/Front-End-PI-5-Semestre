import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import 'FlightDetailView.dart';
import 'package:intl/intl.dart'; // Importando para formatação de data

class FlightHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Voos', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366), // Azul escuro
      ),
      body: FutureBuilder(
        future: flightProvider.fetchFlightHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (flightProvider.flightHistory.isEmpty) {
            return Center(child: Text('Nenhum voo registrado.', style: TextStyle(fontSize: 18)));
          }

          return ListView.builder(
            itemCount: flightProvider.flightHistory.length,
            itemBuilder: (context, index) {
              final flightData = flightProvider.flightHistory[index];
              final flightName = '${flightData['departure']} Até ${flightData['arrival']}';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: ListTile(
                  title: Text(flightName, style: TextStyle(fontWeight: FontWeight.bold)),
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
                          icon: Icon(Icons.check, color: Color(0xFF007BFF)), // Azul
                          onPressed: () {
                            _showConcludeFlightDialog(context, flightProvider, index);
                          },
                        )
                      : null,
                ),
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
          title: Text('Relizar Previsão', style: TextStyle(color: Color(0xFF003366))),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (selectedDate != null) {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          departureTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          setState(() {}); // Atualiza a interface para mostrar a nova data
                        }
                      }
                    },
                    child: Text('Selecionar Data e Hora da Partida'),
                  ),
                  SizedBox(height: 8),
                  Text(departureTime != null ? 'Partida: ${DateFormat('dd/MM/yyyy HH:mm').format(departureTime!)}' : 'Nenhuma data selecionada'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (selectedDate != null) {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          arrivalTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          setState(() {}); // Atualiza a interface para mostrar a nova data
                        }
                      }
                    },
                    child: Text('Selecionar Data e Hora da Chegada'),
                  ),
                  SizedBox(height: 8),
                  Text(arrivalTime != null ? 'Chegada: ${DateFormat('dd/MM/yyyy HH:mm').format(arrivalTime!)}' : 'Nenhuma data selecionada'),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (departureTime != null && arrivalTime != null) {
                  if (arrivalTime!.isBefore(departureTime!)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('A data de chegada deve ser após a data de partida.')));
                  } else {
                    flightProvider.concludeFlight(index, departureTime!, arrivalTime!);
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Datas inválidas!')));
                }
              },
              child: Text('Prever', style: TextStyle(color: Color(0xFF007BFF))),
            ),
          ],
        );
      },
    );
  }
}
