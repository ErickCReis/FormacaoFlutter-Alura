import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/widgets.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const AppDependencies({
    required this.contactDao,
    required this.transactionWebClient,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>()!;

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) =>
      contactDao != oldWidget.contactDao ||
      transactionWebClient != oldWidget.transactionWebClient;
}
