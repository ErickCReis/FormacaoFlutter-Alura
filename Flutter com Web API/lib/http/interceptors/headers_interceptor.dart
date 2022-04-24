import 'package:http_interceptor/http_interceptor.dart';

class HeadersInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers.addAll({
      'Content-type': 'application/json',
    });
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
