import 'package:flutter/widgets.dart';

class Saldo extends ChangeNotifier {
  final double valor;

  Saldo(this.valor);

  @override
  String toString() {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
