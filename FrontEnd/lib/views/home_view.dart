import 'package:flutter/material.dart';
import 'input_flight_view.dart';
import 'flight_history_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Imagem de fundo
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset( 
              'assets/background.jpg',  // Coloque uma imagem de fundo no diretório assets
              fit: BoxFit.cover,
            ),
          ),
          // Filtro escuro para melhorar a legibilidade do texto
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Filtro escuro
            ),
          ),
          // Conteúdo da tela
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título da tela
                  Text(
                    'Bem-vindo ao AirWise!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  // Botão "Inserir Novo Voo"
                  _buildButton(
                    context,
                    label: 'Inserir Novo Voo',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InputFlightView()),
                      );
                    },
                    icon: Icons.add,
                  ),
                  SizedBox(height: 20),
                  // Botão "Ver Histórico de Voos"
                  _buildButton(
                    context,
                    label: 'Ver Histórico de Voos',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FlightHistoryView()),
                      );
                    },
                    icon: Icons.history,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Função para criar os botões de forma reutilizável
  Widget _buildButton(BuildContext context, {required String label, required VoidCallback onPressed, required IconData icon}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28),
      label: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF007BFF), // Azul
        foregroundColor: Colors.white, // Cor do texto e ícone
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.6),
      ),
    );
  }
}
