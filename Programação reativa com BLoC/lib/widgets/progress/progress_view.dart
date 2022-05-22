import 'package:bytebank/widgets/progress/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressView extends StatelessWidget {
  final String message;

  const ProgressView({
    this.message = 'Sending ...',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: const Progress(message: 'Sending...'),
    );
  }
}
