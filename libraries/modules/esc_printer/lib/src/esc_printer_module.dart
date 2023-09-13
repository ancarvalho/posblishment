import 'package:core/core.dart';
import 'package:esc_printer/src/presenter/pages/printer_test/printer_test_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ESCPrinter extends Module {
  @override
  final List<Bind> binds = [

    
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(PagesRoutes.posPrinter.route, child: (_, args) => const PrinterTestPage()),
    
  ];
}