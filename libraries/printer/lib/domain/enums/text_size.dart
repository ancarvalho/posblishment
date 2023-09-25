/*
sizes are measured as theoretical number with Elgin i9 with font A

*/

enum TextSize {
  textSizeNormal(name: "TEXT_SIZE_NORMAL", value: [0x1D, 0x21, 0x00], size: 1/4),
  textSizeDoubleHeight(name: "TEXT_SIZE_DOUBLE_HEIGHT", value: [0x1D, 0x21, 0x01], size: 1/2),
  textSizeDoublewidth(name: "TEXT_SIZE_DOUBLE_WIDTH", value: [0x1D, 0x21, 0x10], size: 1/2),
  textSizeBig(name: "TEXT_SIZE_BIG", value: [0x1D, 0x21, 0x11], size: 1/2),
  textSizeBig2(name: "TEXT_SIZE_BIG_2", value: [0x1D, 0x21, 0x22], size: 3/4),
  textSizeBig3(name: "TEXT_SIZE_BIG_3", value: [0x1D, 0x21, 0x33], size: 1),
  textSizeBig4(name: "TEXT_SIZE_BIG_4", value: [0x1D, 0x21, 0x44], size: 4/3),
  textSizeBig5(name: "TEXT_SIZE_BIG_5", value: [0x1D, 0x21, 0x55], size: 3/2),
  textSizeBig6(name: "TEXT_SIZE_BIG_6", value: [0x1D, 0x21, 0x66], size: 2);

  const TextSize({required this.name, required this.value, required this.size});

  final String name;
  final List<int> value;
  final double size; // column size by char
}
