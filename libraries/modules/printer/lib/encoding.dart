class EscPosCharsetEncoding {
  final String charsetName;
  final int charsetCode;
  late List<int> charsetCommand;

  EscPosCharsetEncoding({
    required this.charsetName,
    required this.charsetCode,
  }) {
    charsetCommand = [0x1B, 0x74, charsetCode];
  }
}
