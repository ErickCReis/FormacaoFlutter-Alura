import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

final Uri baseUrl = Uri.parse('http://localhost:8080/transactions');
