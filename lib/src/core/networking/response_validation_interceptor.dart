import 'package:dio/dio.dart';

class ResponseValidationInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200 && (response.data['result'] == "success")) {
      handler.next(response);
    } else {
      String? message = response.data['message'];
      Map<String, dynamic>? error = response.data['data'];
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: error,
          message: message,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final data = (err.response?.data is List)
        ? err.response?.data[0]
        : err.response?.data;
    final error = data['errors'];
    final message = data['message'];
    super.onError(
        DioException(
          requestOptions: err.requestOptions,
          error: error,
          type: err.type,
          message: message,
        ),
        handler);
  }
}
