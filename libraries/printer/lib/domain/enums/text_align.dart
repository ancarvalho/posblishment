enum TextAlign {
  textAlignLeft(name: "TEXT_ALIGN_LEFT", value: [0x1B, 0x61, 0x00]),
  textAlignCenter(name: "TEXT_ALIGN_CENTER", value: [0x1B, 0x61, 0x01]),
  textAlignRight(name: "TEXT_ALIGN_RIGHT", value: [0x1B, 0x61, 0x02]);

  const TextAlign({required this.name, required this.value});

  final String name;
  final List<int> value;
}
