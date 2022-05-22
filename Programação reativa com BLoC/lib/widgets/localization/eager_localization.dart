import 'package:bytebank/widgets/localization/locale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewI18N {
  late String _language;

  ViewI18N(BuildContext context) {
    _language = context.read<CurrentLocaleCubit>().state;
  }

  String localize(Map<String, String> map) {
    assert(map.isNotEmpty);
    return map[_language] ?? map.values.first;
  }
}
