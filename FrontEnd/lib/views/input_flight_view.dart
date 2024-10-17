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
        title: Text('Inserir Novo Voo', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: departureController,
                decoration: InputDecoration(
                  labelText: 'Ponto de Partida',
                  labelStyle: TextStyle(color: Color(0xFF007BFF)),
                  border: OutlineInputBorder(),
                ),
                onChanged: flightProvider.setDeparture,
              ),
              SizedBox(height: 20),
              TextField(
                controller: arrivalController,
                decoration: InputDecoration(
                  labelText: 'Ponto de Chegada',
                  labelStyle: TextStyle(color: Color(0xFF007BFF)),
                  border: OutlineInputBorder(),
                ),
                onChanged: flightProvider.setArrival,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (departureController.text.isEmpty || arrivalController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, preencha os campos de partida e chegada.')),
                    );
                    return;
                  }

                  await flightProvider.fetchFlightData();

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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nenhum voo cadastrado.')),
                    );
                  }
                },
                child: Text('Buscar Dados do Voo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
