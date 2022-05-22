import 'package:bytebank/widgets/localization/i18n_container.dart';
import 'package:bytebank/widgets/localization/i18n_cubit.dart';
import 'package:bytebank/widgets/localization/i18n_state.dart';
import 'package:bytebank/widgets/error.dart';
import 'package:bytebank/widgets/progress/progress_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NMessageCreator creator;

  const I18NLoadingView(this.creator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessageCubit, I18NMessagesState>(
      builder: (_, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return const ProgressView(message: 'Loading...');
        }

        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return creator(messages);
        }

        return const ErrorView('Error loading messages');
      },
    );
  }
}
