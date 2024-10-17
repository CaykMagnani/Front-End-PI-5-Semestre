import 'package:flutter/material.dart';
import 'input_flight_view.dart';
import 'flight_history_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirWise', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366), // Azul escuro
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bem-vindo ao AirWise!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366), // Azul escuro
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputFlightView()),
                  );
                },
                child: Text('Inserir Novo Voo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF), // Azul
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlightHistoryView()),
                  );
                },
                child: Text('Ver Histórico de Voos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF), // Azul
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
