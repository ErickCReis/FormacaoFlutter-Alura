import 'package:bytebank/widgets/localization/eager_localization.dart';
import 'package:bytebank/widgets/localization/i18n_messages.dart';
import 'package:flutter/widgets.dart';

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
