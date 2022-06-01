import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    BytebankApp(
      contactDao: ContactDao(),
      transactionWebClient: TransactionWebClient(),
    ),
  );
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const BytebankApp({
    required this.contactDao,
    required this.transactionWebClient,
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green.shade900,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.green.shade900,
                secondary: Colors.blueAccent.shade700,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.blueAccent.shade700,
            ),
          ),
        ),
        home: const Dashboard(),
      ),
    );
  }
}
