import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../domain/errors/management_failures.dart';

class ManagementErrorWidget extends StatelessWidget {
  final Failure? error;
  final VoidCallback reload;
  const ManagementErrorWidget({super.key, required this.error, required this.reload});

  @override
  Widget build(BuildContext context) {
    if (error is NoDataFound) {
      return const Center(child: Text('No Data'));
    }
    if (error is ManagementNoInternetConnection) {
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
