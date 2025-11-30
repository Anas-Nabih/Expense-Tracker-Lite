import 'package:dio/dio.dart';
import 'package:expense_tracker_lite/src/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkService {
  Future<Response> get({
    Map<String, dynamic>? queryParameters,
    required String path,
    Options? options,
  });
}

@Injectable(as: NetworkService)
class DioService extends NetworkService {
  final Dio _dio;

  DioService(
    Dio dio,
  ) : _dio = dio;

  @override
  Future<Response> get({
    Map<String, dynamic>? queryParameters,
    required String path,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(error: e.message);
    }
  }
}
