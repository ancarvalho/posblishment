import 'package:administration/src/presenter/widgets/item/item_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({super.key, required this.request});
  final Request request;

  @override
  Widget build(BuildContext context) {
    if (request.items == null) return Column();

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(request.id),
            Text(request.observation ?? ""),
          ],
        ),
        ...request.items!.map((e) => ItemWidget(item: e)).toList()
      ],
    );
  }
}
