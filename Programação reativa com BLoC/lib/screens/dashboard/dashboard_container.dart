import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank/screens/dashboard/dashboard_view.dart';
import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/localization/i18n_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Erick'),
      child: I18NLoadingContainer(
        viewKey: 'dashboard',
        creator: (messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}
