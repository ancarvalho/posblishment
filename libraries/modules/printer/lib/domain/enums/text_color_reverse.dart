
enum TextColorReverse {
  textColorReverseOff(name: "TEXT_COLOR_REVERSE_OFF", value:  [0x1D, 0x42, 0x00]),
  textColorReverseOn(name: "TEXT_COLOR_REVERSE_ON", value: [0x1D, 0x42, 0x01]);

  const TextColorReverse({required this.name, required this.value});

  final String name;
  final List<int> value;
}
