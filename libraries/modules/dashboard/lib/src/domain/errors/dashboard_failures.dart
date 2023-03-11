import 'package:core/core.dart';

class NoDataFound extends Failure {}

abstract class NoInternetConnection extends Failure {
  NoInternetConnection() : super(errorMessage: 'No Internet Connection');
}

class DashboardNoInternetConnection extends NoInternetConnection {}

class DashboardError extends Failure {
  DashboardError(
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