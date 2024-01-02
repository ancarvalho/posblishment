import 'dart:io';

import 'package:printer/domain/connection/device_connection.dart';
import 'package:printer/domain/errors/printer_erros.dart';

class TCPConnection extends DeviceConnection {
  Socket? _socket;
  final String address;
  late final int port;
  final int timeout;

  TCPConnection({required this.address, int? newPort, this.timeout = 5})
      : super() {
    port = newPort ?? 9100;
  }

  @override
  bool isConnected() {
    return _socket != null;
  }



  @override
  Future<TCPConnection> connect() async {
    if (isConnected()) {
      return this;
    }

    try {
      _socket = await Socket.connect(
        address,
        port,
        timeout: Duration(seconds: timeout),
      );
    } catch (e, s) {
      _socket = null;
      throw PrinterError(
        s,
        "PrinterLib-Unable-to-Connect",
        e,
        e.toString(),
      );
    }

    return this;
  }

  @override
  Future<void> closeConnection() async {
    if (isConnected()) {
      try {
        await _socket?.close();
        _socket = null;
      } catch (e, s) {
        throw PrinterError(
          s,
          "PrinterLib-Error-ON-Disconnect",
          e,
          e.toString(),
        );
      }
    }
  }

  @override
  void send({int? addWaitingTime}) {
    _send(addWaitingTime ?? 0);
  }

  Future<void> _send(int addWaitingTime) async {
    if (!isConnected()) {
      throw PrinterError(
        StackTrace.current,
        "PrinterLib-Error-ON-Send",
        "",
        "Error Ocurred Due Socket No Connection",
      );
    }
    try {
      _socket?.add(data);
      data = [];
    } catch (e, s) {
      throw PrinterError(
        s,
        "PrinterLib-Error-ON-Send",
        e,
        e.toString(),
      );
    }
  }
}
