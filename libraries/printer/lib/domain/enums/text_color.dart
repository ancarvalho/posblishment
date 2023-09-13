enum TextColor {
  textColorBlack(name: "TEXT_COLOR_BLACK", value: [0x1B, 0x72, 0x00]),
  textColorRed(name: "TEXT_COLOR_RED", value: [0x1B, 0x72, 0x01]);

  const TextColor({required this.name, required this.value});

  final String name;
  final List<int> value;
}
