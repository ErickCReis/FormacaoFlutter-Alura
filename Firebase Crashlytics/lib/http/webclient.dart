import 'package:bytebank/http/interceptors/headers_interceptor.dart';
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [
    HeadersInterceptor(),
    LoggingInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 5),
);

final Uri baseUrl = Uri(
  scheme: 'http',
  host: 'localhost',
  port: 8080,
);

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.getMessage(int statusCode, Map<int, String> messages)
      : message = _getMessage(statusCode, messages);

  static String _getMessage(int statusCode, Map<int, String> messages) {
    if (messages.containsKey(statusCode)) {
      return messages[statusCode]!;
    }

    return 'Code $statusCode: Unknown error';
  }
}
