enum TextFont {
  textFontA(name: "TEXT_FONT_A", value: [0x1B, 0x4D, 0x00]),
  textFontB(name: "TEXT_FONT_B", value: [0x1B, 0x4D, 0x01]),
  textFontC(name: "TEXT_FONT_C", value: [0x1B, 0x4D, 0x02]),
  textFontD(name: "TEXT_FONT_D", value: [0x1B, 0x4D, 0x03]),
  textFontE(name: "TEXT_FONT_E", value: [0x1B, 0x4D, 0x04]);

  const TextFont({required this.name, required this.value});

  final String name;
  final List<int> value;
}
