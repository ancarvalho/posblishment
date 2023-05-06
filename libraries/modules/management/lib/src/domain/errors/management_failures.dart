import 'package:core/core.dart';
import "package:drift/drift.dart";

abstract class NoInternetConnection extends Failure {
  NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class ManagementNoInternetConnection extends NoInternetConnection {}

class ManagementError extends Failure {
  ManagementError(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}

class InternalDatabaseErrorDataException extends Failure {
  InternalDatabaseErrorDataException(
    StackTrace stackTrace,
    String label,
    dynamic exception,
    String errorMessage,
  ) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
          errorMessage: errorMessage,
        );
}
