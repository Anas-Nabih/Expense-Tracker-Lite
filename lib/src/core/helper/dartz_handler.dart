import 'package:dartz/dartz.dart';
import 'package:expense_tracker_lite/src/core/error/exceptions.dart';
import 'package:expense_tracker_lite/src/core/error/failures.dart';

mixin DartzHandler {
  Future<Either<Failure, T>> eitherHandler<T>(
      Future<T> Function() callback) async {
    try {
      final result = await callback();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(
        e.message,
      ));
    }
  }
}
