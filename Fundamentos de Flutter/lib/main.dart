import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTranferencias(),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando tranferência'),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: 'Número da conta',
            dica: '0000',
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: 'Valor',
            dica: '0.00',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            child: const Text('Confirmar'),
            onPressed: () => _criaTransferencia(context),
          )
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta == null || valor == null) {
      return;
    }
    final tranferenciaCriada = Transferencia(valor, numeroConta);
    Navigator.pop(context, tranferenciaCriada);
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  const Editor({
    Key? key,
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTranferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = [];

  ListaTranferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(200.0, 1000));
    _transferencias.add(Transferencia(200.0, 2000));
    _transferencias.add(Transferencia(200.0, 3000));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (_, indece) => ItemTranferencia(_transferencias[indece]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormularioTransferencia(),
            ),
          );

          future.then((tranferenciaRecebida) {
            debugPrint('$tranferenciaRecebida');
            if (tranferenciaRecebida == null) {
              return;
            }

            _transferencias.add(tranferenciaRecebida);
          });
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

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
