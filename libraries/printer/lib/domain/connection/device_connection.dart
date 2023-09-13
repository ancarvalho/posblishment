// ignore_for_file: unnecessary_this

abstract class DeviceConnection {
  List<int> data = [];

  void write(List<int> d) {
    this.data += d;
  }

  bool isConnected();
  Future<DeviceConnection> connect();
  Future<DeviceConnection> disconnect();
  void send({int? addWaitingTime});
}
