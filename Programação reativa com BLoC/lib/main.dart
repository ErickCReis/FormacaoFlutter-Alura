import 'package:bytebank/screens/dashboard/dashboard_container.dart';
import 'package:bytebank/widgets/localization/locale.dart';
import 'package:bytebank/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} > $change');
  }
}

void main() {
  BlocOverrides.runZoned(
    () => runApp(const BytebankApp()),
    blocObserver: LogObserver(),
  );
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: bytebankTheme,
      home: const LocalizationContainer(
        child: DashboardContainer(),
      ),
    );
  }
}
