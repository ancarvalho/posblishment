enum TextUnderline {

  textUnderlineOff(name: "TEXT_UNDERLINE_OFF", value:  [0x1B, 0x2D, 0x00]),
  textUnderlineOn(name: "TEXT_UNDERLINE_ON", value:  [0x1B, 0x2D, 0x01]),
  textUnderlineLarge(name: "TEXT_UNDERLINE_LARGE", value:  [0x1B, 0x2D, 0x02]);

  const TextUnderline({required this.name, required this.value});

  final String name;
  final List<int> value;
}
