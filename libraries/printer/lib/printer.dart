library printer;

import 'package:printer/text_styles.dart';

import 'commands.dart';

class Printer {
  // Printer._({
  //   required this.commands,
  // });

  static PrinterCommands printerTCPConnection({
    required String address,
    int? port,
    int? timeout,
    PrinterTextStyle? printerTextStyle,
  }) {
    final commands = PrinterCommands(
      address: address,
      port: port,
      textStyle: printerTextStyle,
    );

    return commands;
  }

  // final PrinterCommands commands;
}
