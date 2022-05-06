import 'dart:math';

import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _titulo = 'Últimas Transferências';

class UltimasTranferencias extends StatelessWidget {
  const UltimasTranferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            _titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<Transferencias>(
            builder: (_, transferencias, __) {
              final size = transferencias.transferencias.length;

              if (size == 0) {
                return const SemTransferencias();
              }

              return ListView.builder(
                itemCount: min(size, 2),
                shrinkWrap: true,
                itemBuilder: (_, indice) => ItemTranferencia(
                  transferencias.transferencias[size - indice - 1],
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ListaTranferencias(),
              ),
            ),
            child: const Text('Ver todas transferências'),
          )
        ],
      ),
    );
  }
}

class SemTransferencias extends StatelessWidget {
  const SemTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Nenhuma transferência encontrada'),
      ),
    );
  }
}
