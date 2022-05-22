import 'package:bytebank/http/webclients/i18n_webclient.dart';
import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/error.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  const LocalizationContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (_) => CurrentLocaleCubit(),
      child: child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super('pt-br');
}

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

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;

  const LoadedI18NMessagesState(this._messages);
}

class I18NMessages {
  final Map<String, String> _messages;

  I18NMessages(this._messages);

  String get(String key) {
    assert(_messages.containsKey(key));
    return _messages[key]!;
  }
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}

class I18NMessageCubit extends Cubit<I18NMessagesState> {
  I18NMessageCubit() : super(const InitI18NMessagesState());

  void reload(I18NWebClient client) {
    emit(const LoadingI18NMessagesState());

    client.findAll().then((messages) {
      emit(LoadedI18NMessagesState(I18NMessages(messages)));
    });
  }
}

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
        final cubit = I18NMessageCubit();
        final language = context.read<CurrentLocaleCubit>().state;
        cubit.reload(I18NWebClient(language, viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}

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
          final messages = state._messages;
          return creator(messages);
        }

        return const ErrorView('Error loading messages');
      },
    );
  }
}
