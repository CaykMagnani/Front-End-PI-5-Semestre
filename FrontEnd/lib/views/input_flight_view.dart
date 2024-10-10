import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import 'FlightDetailView.dart';

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
      body: SingleChildScrollView( // Adicionado para evitar overflow
        child: Padding(
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
                  
                  // Chama o último voo cadastrado no histórico
                  final lastFlightIndex = flightProvider.flightHistory.length - 1;
                  if (lastFlightIndex >= 0) {
                    final lastFlightData = flightProvider.flightHistory[lastFlightIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightDetailView(flightData: lastFlightData),
                      ),
                    );
                  } else {
                    // Lógica para lidar com a ausência de voos
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nenhum voo cadastrado.')),
                    );
                  }
                },
                child: Text('Buscar Dados do Voo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
