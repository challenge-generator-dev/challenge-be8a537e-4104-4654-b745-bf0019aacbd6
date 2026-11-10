class Failure {
  final String message;
  final Map<String, dynamic>? details;

  Failure(this.message, {this.details});

  @override
  String toString() => 'Failure: $message${details != null ? ' - $details' : ''}';
}

class NetworkFailure extends Failure {
  NetworkFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class ServerFailure extends Failure {
  ServerFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class CacheFailure extends Failure {
  CacheFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}