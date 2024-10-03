import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';

class InputFlightView extends StatelessWidget {
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final flightProvider = Provider.of<FlightProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Novo Voo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: departureController,
              decoration: InputDecoration(labelText: 'Ponto de Partida'),
              onChanged: flightProvider.setDeparture,
            ),
            TextField(
              controller: arrivalController,
              decoration: InputDecoration(labelText: 'Ponto de Chegada'),
              onChanged: flightProvider.setArrival,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await flightProvider.fetchFlightData();
                Navigator.pop(context); // Retornar à tela anterior
              },
              child: Text('Buscar Dados do Voo'),
            ),
          ],
        ),
      ),
    );
  }
}