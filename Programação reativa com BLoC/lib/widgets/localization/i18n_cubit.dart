import 'package:bytebank/widgets/localization/i18n_messages.dart';
import 'package:bytebank/widgets/localization/i18n_state.dart';
import 'package:bytebank/http/webclients/i18n_webclient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class I18NMessageCubit extends Cubit<I18NMessagesState> {
  final String _language;
  final String _viewKey;

  late LocalStorage _storage;
  late I18NWebClient _client;

  I18NMessageCubit(
    this._language,
    this._viewKey,
  ) : super(const InitI18NMessagesState()) {
    _storage = LocalStorage('insecure_v1.json');
    _client = I18NWebClient(_language, _viewKey);
  }

  void reload() async {
    emit(const LoadingI18NMessagesState());

    await _storage.ready;

    final result = _storage.getItem(_key);
    if (result != null) {
      final items = Map<String, String>.from(result);
      emit(LoadedI18NMessagesState(I18NMessages(items)));
      return;
    }

    _client.findAll().then(_saveAndRefresh);
  }

  void _saveAndRefresh(Map<String, String> messages) {
    _storage.setItem(_key, messages);
    emit(LoadedI18NMessagesState(I18NMessages(messages)));
  }

  String get _key => '${_language}_$_viewKey';
}
