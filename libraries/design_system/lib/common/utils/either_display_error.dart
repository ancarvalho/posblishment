import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';

void eitherDisplayError<T>(BuildContext context, Either<Failure, T> v) {
  v.fold(
    (l) => displayMessageOnSnackbar(
      context,
      l.errorMessage,
    ),
    (r) => null,
  );
}
