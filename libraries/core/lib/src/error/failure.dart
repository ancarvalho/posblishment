import 'package:flutter/foundation.dart';

abstract class Failure implements Exception {
  final String errorMessage;

  Failure({
    StackTrace? stackTrace,
    String? label,
    dynamic exception,
    this.errorMessage = '',
  }) {
    if (stackTrace != null) {
      debugPrintStack(label: label, stackTrace: stackTrace);
    }
    //Store Error on Storage or service

    if (kDebugMode) {
      print(exception);
    }
  }
}

class NoDataFound extends Failure {
  NoDataFound() : super(errorMessage: 'No data found OR no internet');
}


class UnknownError extends Failure {
  final dynamic exception;
  final StackTrace? stackTrace;
  final String? label;

  UnknownError({
    this.label,
    this.exception,
    this.stackTrace,
    super.errorMessage = 'Unknown Error',
  }) : super(
          stackTrace: stackTrace,
          label: label,
          exception: exception,
        );
}
