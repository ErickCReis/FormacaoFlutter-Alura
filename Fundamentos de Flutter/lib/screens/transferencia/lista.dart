import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Tranferências';

class ListaTranferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTranferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciasState();
  }
}

class ListaTranferenciasState extends State<ListaTranferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (_, indece) =>
            ItemTranferencia(widget._transferencias[indece]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push<Transferencia>(
            context,
            MaterialPageRoute(
              builder: (_) => FormularioTransferencia(),
            ),
          ).then(_atualiza);
        },
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    if (transferenciaRecebida == null) {
      return;
    }

    setState(() {
      widget._transferencias.add(transferenciaRecebida);
    });
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
        title: Text(_tranferencia.valor.toString()),
        subtitle: Text(_tranferencia.numeroConta.toString()),
      ),
    );
  }
}
