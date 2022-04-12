import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tranferências'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        body: ListaTranferencias(),
      ),
    ),
  );
}

class ListaTranferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTranferencia(Transferencia(100.0, 1000)),
        ItemTranferencia(Transferencia(200.0, 2000)),
        ItemTranferencia(Transferencia(300.0, 3000)),
      ],
    );
  }
}

class ItemTranferencia extends StatelessWidget {
  final Transferencia _tranferencia;

  const ItemTranferencia(this._tranferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_tranferencia.valor.toString()),
        subtitle: Text(_tranferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
