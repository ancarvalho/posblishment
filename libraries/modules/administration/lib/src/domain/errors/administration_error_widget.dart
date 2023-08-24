import 'package:administration/src/domain/errors/administration_errors.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AdministrationErrorWidget extends StatelessWidget {
  final Failure? error;
  final VoidCallback reload;
  const AdministrationErrorWidget({super.key, required this.error, required this.reload});

  @override
  Widget build(BuildContext context) {
    if (error is NoDataFound) {
      return const Center(child: Text('No Data'));
    }
    if (error is AdministrationNoInternetConnection) {
      return Center(
        child: NoInternetWidget(
          message: AppConstant.noInternetConnection,
          onPressed: reload,
        ),
      );
    }
    return CustomErrorWidget(message: error?.errorMessage);
  }
}
