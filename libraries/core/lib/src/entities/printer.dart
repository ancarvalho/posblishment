class PrinterSettings {

  final bool enablePrinter;
  final String? printerIp;
  final int? printerPort;


  const PrinterSettings({

    this.enablePrinter = false,
    this.printerIp,
    this.printerPort = 9100,

  });

  factory PrinterSettings.empty() {
    return const PrinterSettings();
  }

  PrinterSettings copyWith({
   
    bool? enablePrinter,
    String? printerIp,
    int? printerPort,

  }) {
    return PrinterSettings(
     
      enablePrinter: enablePrinter ?? this.enablePrinter,
      printerIp: printerIp ?? this.printerIp,
      printerPort: printerPort ?? this.printerPort,
    );
  }

  static PrinterSettings fromMap(dynamic map) {
    return PrinterSettings(
        
        enablePrinter: map["enable_printer"],
        printerIp: map["printer_ip"],
        printerPort: map["printer_port"],
     );
  }

  static Map<String, dynamic> toJson(PrinterSettings printerSettings) {
    return {

      "enable_printer": printerSettings.enablePrinter,
      "printer_ip": printerSettings.printerIp,
      "printer_port": printerSettings.printerPort,
     
    };
  }
}
