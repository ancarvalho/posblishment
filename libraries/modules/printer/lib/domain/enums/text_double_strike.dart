enum TextDoubleStrike {
  textDoubleStrikeOff(name: "TEXT_DOUBLE_STRIKE_OFF", value:  [0x1B, 0x47, 0x00]),
  textDoubleStrikeOn(name: "TEXT_DOUBLE_STRIKE_ON", value:  [0x1B, 0x47, 0x01]);
  
  const TextDoubleStrike({required this.name, required this.value});

  final String name;
  final List<int> value;
}
