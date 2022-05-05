import 'package:bytebank/screens/dashboard/saldo_card.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FormularioDeposito(),
              ),
            ),
            child: const Text('Receber depósito'),
          )
        ],
      ),
    );
  }
}
