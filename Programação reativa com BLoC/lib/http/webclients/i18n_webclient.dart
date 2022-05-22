import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';

const String baseUri =
    'https://gist.githubusercontent.com/ErickCReis/cfb5392b90f19d9f3531cf59ae638cf3/raw/027b15a8c1048b2e39b4d3388068ea6c647f8961';

class I18NWebClient {
  final String _language;
  final String _viewKey;

  I18NWebClient(this._language, this._viewKey);

  Future<Map<String, String>> findAll() async {
    final Response response = await client.get(
      Uri.parse('$baseUri/${_viewKey}_$_language.json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      return decodedJson.map((String key, dynamic value) {
        return MapEntry(key, value.toString());
      });
    }

    return {};
  }
}
