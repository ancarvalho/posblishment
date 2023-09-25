/*
sizes are measured as theoretical number with Elgin i9 with font A 80mm

*/



enum TextFont {
  textFontA(name: "TEXT_FONT_A", value: [0x1B, 0x4D, 0x00], columns: 12),
  textFontB(name: "TEXT_FONT_B", value: [0x1B, 0x4D, 0x01], columns: 9),
  textFontC(name: "TEXT_FONT_C", value: [0x1B, 0x4D, 0x02], columns: 9);
  // textFontD(name: "TEXT_FONT_D", value: [0x1B, 0x4D, 0x03], columns:  9),
  // textFontE(name: "TEXT_FONT_E", value: [0x1B, 0x4D, 0x04], columns:  9);

  const TextFont({required this.name, required this.value, required this.columns});

  final String name;
  final List<int> value;
  final int columns;
}
