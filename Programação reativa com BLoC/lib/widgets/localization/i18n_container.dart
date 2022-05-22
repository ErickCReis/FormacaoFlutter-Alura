import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/localization/i18n_cubit.dart';
import 'package:bytebank/widgets/localization/i18n_messages.dart';
import 'package:bytebank/widgets/localization/locale.dart';
import 'package:bytebank/widgets/localization/i18n_loading_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef I18NMessageCreator = Widget Function(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final String viewKey;
  final I18NMessageCreator creator;

  const I18NLoadingContainer({
    required this.viewKey,
    required this.creator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessageCubit>(
      create: (_) {
        final language = context.read<CurrentLocaleCubit>().state;
        final cubit = I18NMessageCubit(language, viewKey);
        cubit.reload();
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}
