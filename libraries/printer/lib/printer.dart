library printer;

import 'package:printer/domain/connection/tcp/tcp_connection.dart';
import 'package:printer/text_styles.dart';

import 'commands.dart';

class Printer {
  Printer._({
    required this.commands,
  });

  static PrinterCommands printerTCPConnection(
      {required String address,
      int? port,
      int? timeout,
      PrinterTextStyle? printerTextStyle}) {
    final printer = TCPConnection(address: address);
    final commands = PrinterCommands(
        printerConnection: printer, textStyle: printerTextStyle);

    return commands;
  }

  final PrinterCommands commands;
}
