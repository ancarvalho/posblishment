import 'package:administration/src/presenter/widgets/item/item_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/common/utils/paddings.dart';
import 'package:flutter/material.dart';

import '../dialog/reprint_request_dialog.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({super.key, required this.request, this.table});
  final Request request;
  final int? table;

  @override
  Widget build(BuildContext context) {
    if (request.items == null) return Column();
    final date = DateTime.now().difference(request.createdAt);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) =>
              ReprintRequestDialog(requestID: request.id, table: table ?? 0),
        );
      },
      child: Card(
        child: Padding(
          padding: Paddings.paddingLTRB4(),
          child: Stack(
            children: [
              Positioned(
                // mainAxisAlignment: MainAxisAlignment.center,
                bottom: 0,
                right: 0,
                child: Text("${date.inMinutes}min atrás"),
                // if (request.observation != null) Text(request.observation!),
              ),
              Padding(
                padding: Paddings.paddingLTRB20(),
                child: Column(
                  children:
                      request.items!.map((e) => ItemWidget(item: e)).toList(),
                ),
              ),
              Align(
                // mainAxisAlignment: MainAxisAlignment.center,
                alignment: Alignment.bottomCenter,
                child: Text(request.observation ?? ""),
                // if (request.observation != null) Text(request.observation!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
