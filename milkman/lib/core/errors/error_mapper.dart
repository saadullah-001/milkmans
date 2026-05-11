import 'package:milkman/core/errors/exceptions.dart';
import 'package:milkman/core/errors/failure.dart';

class ErrorMapper {
  const ErrorMapper();

  Failure map(Object error) {
    // map exception caught and map it to failure and return Fialure
    if (error is AppException) {
      return switch (error) {
        NetworkException() => NetworkFailure(
          message: error.message,
          code: error.code,
        ),
        AuthException() => AuthFailure(
          message: error.message,
          code: error.code,
        ),
        NotFoundException() => NotFoundFailure(
          message: error.message,
          code: error.code,
        ),
        UnknownException() => UnknownFailure(
          message: error.message,
          code: error.code,
        ),
      };
    }
    return UnknownFailure(message: 'Something went wrong');
  }
}
