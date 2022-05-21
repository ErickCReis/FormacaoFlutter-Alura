import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/feature_item.dart';
import 'package:bytebank/widgets/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Erick'),
      child: I18NLoadingContainer(
        (messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  const DashboardView(this._i18n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final i18n = DashboardViewI18N(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (_, name) => Text('Welcome $name'),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FeatureItem(
                  _i18n.tranfer,
                  Icons.monetization_on,
                  onClick: () => _showContactsList(context),
                ),
                FeatureItem(
                  _i18n.transaction_feed,
                  Icons.description,
                  onClick: () => _showTransactionsList(context),
                ),
                FeatureItem(
                  _i18n.change_name,
                  Icons.person_outline,
                  onClick: () => _showChangeName(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context) {
    push(context, const ContactsListContainer());
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TransactionsList(),
      ),
    );
  }

  void _showChangeName(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(context),
          child: const NameContainer(),
        ),
      ),
    );
  }
}

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get tranfer => localize({
        'en': 'Transfer',
        'pt-br': 'Transferir',
      });

  String get transaction_feed => localize({
        'en': 'Transaction feed',
        'pt-br': 'Transações',
      });

  String get change_name => localize({
        'en': 'Change name',
        'pt-br': 'Mudar nome',
      });
}

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String get tranfer => _messages.get('transfer');

  String get transaction_feed => _messages.get('transaction_feed');

  String get change_name => _messages.get('change_name');
}
