import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:stock/src/domain/errors/stock_failures.dart';



class StockControlErrorWidget extends StatelessWidget {
  final Failure? error;
  final VoidCallback reload;
  const StockControlErrorWidget(
      {super.key, required this.error, required this.reload,});

  @override
  Widget build(BuildContext context) {
    if (error is NoDataFound) {
      return const Center(child: Text('No Data'));
    }
    if (error is StockNoInternetConnection) {
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
