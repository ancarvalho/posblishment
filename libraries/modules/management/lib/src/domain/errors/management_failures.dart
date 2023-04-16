import 'package:core/core.dart';

class NoDataFound extends Failure {}

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
