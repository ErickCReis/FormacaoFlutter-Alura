import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;
  final Axis direction;
  final double progressSize;
  final TextStyle textStyle;
  final Color? progressColor;

  const Progress({
    this.message = 'Loading...',
    this.direction = Axis.vertical,
    this.progressSize = 48,
    this.textStyle = const TextStyle(fontSize: 16),
    this.progressColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: progressSize,
              height: progressSize,
              child: CircularProgressIndicator(
                color: progressColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              message,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
