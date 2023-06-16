import 'package:administration/src/presenter/widgets/bill_requests/bill_requests_store.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../request_card/request_card_widget.dart';

class BillRequestsWidget extends StatefulWidget {
  final String billID;
  const BillRequestsWidget({super.key, required this.billID});

  @override
  State<BillRequestsWidget> createState() => _BillRequestsWidgetState();
}

class _BillRequestsWidgetState extends State<BillRequestsWidget> {
  final requestsStore = Modular.get<BillRequestsStore>();

  @override
  void initState() {
    loadRequests();
    super.initState();
  }

  void loadRequests() {
    requestsStore.getBillRequests(widget.billID);
  }

//TODO init store
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BillRequestsStore, Failure, List<Request>>(
      store: requestsStore,
      onState: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            return RequestCardWidget(
              request: state[index],
            );
          },
        );
      },
    );
  }
}
