enum PrinterSize {
  eightyMM(name: "80mm",   value: 44),
  fiftyEightMM(name: "58mm",   value: 44);

  const PrinterSize({required this.name, required this.value});
  final String name;
  final int value;
}
