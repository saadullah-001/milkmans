sealed class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

final class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

final class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

final class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code});
}

final class UnknownException extends AppException {
  const UnknownException(super.message, {super.code});
}
