import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Tranferências';

class ListaTranferencias extends StatelessWidget {
  const ListaTranferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Consumer<Transferencias>(
        builder: (_, transferencias, __) => ListView.builder(
          itemCount: transferencias.transferencias.length,
          itemBuilder: (_, indice) => ItemTranferencia(
            transferencias.transferencias[indice],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<Transferencia>(
            context,
            MaterialPageRoute(
              builder: (_) => FormularioTransferencia(),
            ),
          );
        },
      ),
    );
  }
}

class ItemTranferencia extends StatelessWidget {
  final Transferencia _tranferencia;

  const ItemTranferencia(this._tranferencia, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_tranferencia.valorFormatado),
        subtitle: Text(_tranferencia.contaFormatada),
      ),
    );
  }
}
