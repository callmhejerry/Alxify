import 'package:alxify/constants/error_messages.dart';

abstract class NetworkExceptions implements Exception {
  final String message;
  final int? errorCode;

  const NetworkExceptions({
    required this.message,
    this.errorCode,
  });
}

class ExpiredTokenException extends NetworkExceptions {
  const ExpiredTokenException({
    super.message = ErrorMessages.expiredToken,
    super.errorCode = 401,
  });
}

class NotFoundException extends NetworkExceptions {
  const NotFoundException({
    super.message = ErrorMessages.notFound,
    super.errorCode = 404,
  });
}

class ServerException extends NetworkExceptions {
  const ServerException({
    super.message = ErrorMessages.serverError,
    super.errorCode = 500,
  });
}

class OtherException extends NetworkExceptions {
  const OtherException({super.errorCode, required super.message});
}

class NoInternetException extends NetworkExceptions {
  const NoInternetException({super.message = ErrorMessages.noInternet});
}

class ConnectionException extends NetworkExceptions {
  const ConnectionException({super.message = ErrorMessages.connectionError});
}
