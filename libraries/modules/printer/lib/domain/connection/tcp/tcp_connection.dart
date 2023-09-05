// ignore_for_file: unnecessary_this

import 'dart:io';

import 'package:printer/domain/connection/device_connection.dart';
import 'package:printer/domain/errors/printer_erros.dart';

class TCPConnection extends DeviceConnection {
  Socket? _socket;
  final String address;
  final int port;
  final int timeout;

  TCPConnection({required this.address, this.port = 9100, this.timeout = 3}):super();

  @override
  bool isConnected() {
    return this._socket != null;
  }

  @override
  Future<TCPConnection> connect() async {
    if (isConnected()) {
      return this;
    }

    try {
      this._socket = await Socket.connect(this.address, this.port,
          timeout: Duration(seconds: this.timeout),);
    } catch (e, s) {
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
  Future<TCPConnection> disconnect() async {
    if (this._socket != null) {
      try {
        await this._socket?.close();
        this._socket = null;
      } catch (e, s) {
        throw PrinterError(
          s,
          "PrinterLib-Error-ON-Disconnect",
          e,
          e.toString(),
        );
      }
    }
    return this;
  }

  @override
  void send() {
    this._send(0);
  }

  Future<void> _send(int addWaitingTime) async {
    if (!this.isConnected()) {
      throw PrinterError(
        StackTrace.current,
        "PrinterLib-Error-ON-Send",
        "",
        "Error Ocurred Due Socket No Connection",
      );
    }
    try {
      this._socket?.write(this.data);
      final waitingTime = addWaitingTime + this.data.length / 8;
      await this
          ._socket
          ?.flush()
          .timeout(Duration(milliseconds: waitingTime.toInt()));
      this.data = [0];
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
