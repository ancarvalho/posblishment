import 'package:administration/src/presenter/widgets/last_requests/last_requests_store.dart';
import 'package:core/core.dart';
import 'package:design_system/common/utils/paddings.dart';
import 'package:design_system/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import "package:flutter_modular/flutter_modular.dart";
import 'package:flutter_triple/flutter_triple.dart';

import '../../widgets/request_card/request_card_widget.dart';

class LastRequestsPage extends StatefulWidget {
  const LastRequestsPage({super.key});

  @override
  State<LastRequestsPage> createState() => _LastRequestsPageState();
}

class _LastRequestsPageState extends State<LastRequestsPage> {
  final LastRequestsStore _lastRequestsStore = Modular.get<LastRequestsStore>();

  @override
  void initState() {
    _lastRequestsStore.getLastRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: const Text("Últimos Pedidos"),
          centerTitle: true,
        ),
        body: ScopedBuilder<LastRequestsStore, Failure, List<Request>>(
          store: _lastRequestsStore,
          onState: (context, state) {
            return Padding(
              padding: Paddings.paddingLTRB4(),
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return RequestCardWidget(
                    request: state[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
