enum TextSize {
  textSizeNormal(name: "TEXT_SIZE_NORMAL", value: [0x1D, 0x21, 0x00]),
  textSizeDoubleHeight(name: "TEXT_SIZE_DOUBLE_HEIGHT", value: [0x1D, 0x21, 0x01]),
  textSizeDoublewidth(name: "TEXT_SIZE_DOUBLE_WIDTH", value: [0x1D, 0x21, 0x10]),
  textSizeBig(name: "TEXT_SIZE_BIG", value: [0x1D, 0x21, 0x11]),
  textSizeBig2(name: "TEXT_SIZE_BIG_2", value: [0x1D, 0x21, 0x22]),
  textSizeBig3(name: "TEXT_SIZE_BIG_3", value: [0x1D, 0x21, 0x33]),
  textSizeBig4(name: "TEXT_SIZE_BIG_4", value: [0x1D, 0x21, 0x44]),
  textSizeBig5(name: "TEXT_SIZE_BIG_5", value: [0x1D, 0x21, 0x55]),
  textSizeBig6(name: "TEXT_SIZE_BIG_6", value: [0x1D, 0x21, 0x66]);

  const TextSize({required this.name, required this.value});

  final String name;
  final List<int> value;
}
