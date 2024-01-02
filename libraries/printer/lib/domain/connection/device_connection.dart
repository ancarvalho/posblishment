abstract class DeviceConnection {
  List<int> data = [];

  void write(List<int> newData) {
    // TODO Maybe Printer error in here
    // data += newData;
    data.addAll(newData);
  }

  bool isConnected();
  Future<DeviceConnection> connect();
  Future<void> closeConnection();
  void send({int? addWaitingTime});
}
