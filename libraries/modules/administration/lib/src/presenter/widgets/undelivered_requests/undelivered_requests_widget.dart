import 'package:administration/src/presenter/widgets/undelivered_requests/undelivered_requests_store.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:flutter_triple/flutter_triple.dart";

import '../request_card/request_card_widget.dart';

class LastRequestsWidgets extends StatefulWidget {
  const LastRequestsWidgets({super.key});

  @override
  State<LastRequestsWidgets> createState() => _LastRequestsWidgetsState();
}

class _LastRequestsWidgetsState extends State<LastRequestsWidgets> {

  final undeliveredRequestsStore = Modular.get<UndeliveredRequestsStore>();

  @override
  void initState() {
    loadRequests();
    super.initState();
  }

  void loadRequests() {
    undeliveredRequestsStore.getUndeliveredRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos Pendentes"),
        centerTitle: true,
      ),
      body: ScopedBuilder<UndeliveredRequestsStore, Failure, List<Request>>(
        store: undeliveredRequestsStore,
        onState: (context, requests) {
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
             

              return RequestCardWidget(
                request: requests[index],
              );
            },
          );
        },
      ),
    );
  }
}
