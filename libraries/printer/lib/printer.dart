library printer;

import 'package:printer/domain/connection/tcp/tcp_connection.dart';
import 'package:printer/text_styles.dart';

import 'commands.dart';

class Printer {
  Printer._({
    required this.commands,
  });

  static Printer printerTCPConnection({required String address, int? port, int? timeout, PrinterTextStyle? printerTextStyle}) {
    final printer = TCPConnection(address: address);
    final commands = Commands(printerConnection: printer, textStyle: printerTextStyle);

    return Printer._(commands: commands);
  }

  final Commands commands;
}

