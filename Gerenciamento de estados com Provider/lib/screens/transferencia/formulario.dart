import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando tranferência';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: const Text(_textoBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (!transferenciaValida(context, numeroConta, valor)) {
      return;
    }

    final novaTransferencia = Transferencia(valor!, numeroConta!);
    _atualizaEstado(context, novaTransferencia);
    Navigator.pop(context);
  }

  bool transferenciaValida(
    BuildContext context,
    int? numeroConta,
    double? valor,
  ) {
    final valoresValidos = valor != null && valor > 0 && numeroConta != null;
    if (!valoresValidos) {
      return false;
    }

    final temSaldo = valor <= Provider.of<Saldo>(context, listen: false).valor;
    if (!temSaldo) {
      return false;
    }

    return true;
  }

  void _atualizaEstado(BuildContext context, Transferencia novaTransferencia) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);

    Provider.of<Saldo>(context, listen: false).subtrai(novaTransferencia.valor);
  }
}
