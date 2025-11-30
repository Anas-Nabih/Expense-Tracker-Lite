class CustomException implements Exception {
  final dynamic message;

  CustomException([this.message]);
}

class GeneralException extends CustomException {
  @override
  dynamic get message => "something went wrong";
}

class ServerException implements CustomException {
   late String _message;
  late Map<String, dynamic> _errors;
  int? statusCode;
  ServerException({
    String? error,
    Map<String, dynamic>? errors,
    this.statusCode,
  }) {
    _message = error ?? "something went wrong";
    _errors = errors ?? {};
  }

  @override
  String get message => _message;
  Map<String, dynamic> get errors => _errors;
}