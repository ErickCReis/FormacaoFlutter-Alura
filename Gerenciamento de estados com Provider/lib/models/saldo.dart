import 'package:flutter/widgets.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo(this.valor);

  void adiciona(double valor) {
    this.valor += valor;
    notifyListeners();
  }

  void subtrai(double valor) {
    this.valor -= valor;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
