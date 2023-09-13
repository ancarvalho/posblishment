enum TextWeight {
  textWeightNormal(name: "TEXT_WEIGHT_NORMAL", value: [0x1B, 0x45, 0x00]),
  textWeightBold(name: "TEXT_WEIGHT_BOLD", value: [0x1B, 0x45, 0x01]);

  const TextWeight({required this.name, required this.value});

  final String name;
  final List<int> value;
}
