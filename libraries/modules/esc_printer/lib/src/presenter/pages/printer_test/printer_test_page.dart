import 'package:bitmap/bitmap.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:printer/domain/enums/enums.dart';
import 'package:printer/printer.dart';

class PrinterTestPage extends StatefulWidget {
  const PrinterTestPage({super.key});

  @override
  State<PrinterTestPage> createState() => _PrinterTestPageState();
}

class _PrinterTestPageState extends State<PrinterTestPage> {
  late String ip;
  late String text;
  Printer? printer;

  Future<void> printImage(String path) async {
    if (printer != null && printer!.commands.printerConnection.isConnected()) {
      final bitmap = await Bitmap.fromProvider(AssetImage(path));
      await printer?.commands.printBitmap(bitmap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: Sizes.width(context) * .7,
                  child: TextFormField(
                    onChanged: (value) => ip = value,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: "Endereço"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (printer != null &&
                        printer!.commands.printerConnection.isConnected()) {
                      printer?.commands.disconnect();
                    } else if (ip.isNotEmpty) {
                      debugPrint(ip);
                      printer = Printer.printerTCPConnection(address: ip);
                    }
                  },
                  icon: const Icon(Icons.connected_tv),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    printer?.commands.reset();
                  },
                  icon: const Icon(Icons.lock_reset),
                ),
                IconButton(
                  onPressed: () {
                    printer?.commands.feedPaper(220);
                  },
                  icon: const Icon(Icons.feed),
                ),
                IconButton(
                  onPressed: () {
                    printer?.commands.cutPaper();
                  },
                  icon: const Icon(Icons.cut),
                ),
                IconButton(
                  onPressed: () {
                    printer?.commands.textPrinter();
                  },
                  icon: const Icon(Icons.airline_seat_recline_extra),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: Sizes.width(context) * .7,
                  child: TextFormField(
                    onChanged: (value) => text = value,
                    decoration: const InputDecoration(labelText: "Print Text"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      printer?.commands
                        ?..printText(
                            text,
                            printer?.commands.printerTextStyle.copyWith(
                                textWeight: TextWeight.textWeightBold,
                                textSize: TextSize.textSizeBig,),)
                        ..feedPaper(20);
                    },
                    icon: const Icon(Icons.print),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: Sizes.width(context) * .7,
                  child: TextFormField(
                    onChanged: (value) => text = value,
                    decoration:
                        const InputDecoration(labelText: "Print in QrCode"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      printer?.commands
                        ?..printQRCode(text)
                        ..feedPaper(20);
                    },
                    icon: const Icon(Icons.print),)
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      await printImage("assets/images/grayscale.png");
                    },
                    child: const Text("Print Logo"),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
