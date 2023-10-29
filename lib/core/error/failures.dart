class Failure {
  final String? message;
  final int? code;
  final String? error;

  Failure({this.message, this.code, this.error});
}

class ServerFailure extends Failure {
  ServerFailure({String? message, int? code, String? error})
      : super(message: message, code: code, error: error);
}

class CacheFailure extends Failure {
  CacheFailure({String? message, int? code, String? error})
      : super(message: message, code: code, error: error);
}

class NoInternetFailure extends Failure {
  NoInternetFailure({String? message, int? code, String? error})
      : super(message: message, code: code, error: error);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({String? message, int? code, String? error})
      : super(message: message, code: code, error: error);
}