class Commands {
  static final int LF = 0x0A;

  static final List<int> RESET_PRINTER = [0x1B, 0x40];

  static final List<int> FEED = [0x1B, 0x4A];

  static final List<int> TEXT_ALIGN_LEFT = [0x1B, 0x61, 0x00];
  static final List<int> TEXT_ALIGN_CENTER = [0x1B, 0x61, 0x01];
  static final List<int> TEXT_ALIGN_RIGHT = [0x1B, 0x61, 0x02];

  static final List<int> TEXT_WEIGHT_NORMAL = [0x1B, 0x45, 0x00];
  static final List<int> TEXT_WEIGHT_BOLD = [0x1B, 0x45, 0x01];

  static final List<int> LINE_SPACING_24 = [0x1b, 0x33, 0x18];
  static final List<int> LINE_SPACING_30 = [0x1b, 0x33, 0x1e];

  static final List<int> TEXT_FONT_A = [0x1B, 0x4D, 0x00];
  static final List<int> TEXT_FONT_B = [0x1B, 0x4D, 0x01];
  static final List<int> TEXT_FONT_C = [0x1B, 0x4D, 0x02];
  static final List<int> TEXT_FONT_D = [0x1B, 0x4D, 0x03];
  static final List<int> TEXT_FONT_E = [0x1B, 0x4D, 0x04];

  static final List<int> TEXT_SIZE_NORMAL = [0x1D, 0x21, 0x00];
  static final List<int> TEXT_SIZE_DOUBLE_HEIGHT = [0x1D, 0x21, 0x01];
  static final List<int> TEXT_SIZE_DOUBLE_WIDTH = [0x1D, 0x21, 0x10];
  static final List<int> TEXT_SIZE_BIG = [0x1D, 0x21, 0x11];
  static final List<int> TEXT_SIZE_BIG_2 = [0x1D, 0x21, 0x22];
  static final List<int> TEXT_SIZE_BIG_3 = [0x1D, 0x21, 0x33];
  static final List<int> TEXT_SIZE_BIG_4 = [0x1D, 0x21, 0x44];
  static final List<int> TEXT_SIZE_BIG_5 = [0x1D, 0x21, 0x55];
  static final List<int> TEXT_SIZE_BIG_6 = [0x1D, 0x21, 0x66];

  static final List<int> TEXT_UNDERLINE_OFF = [0x1B, 0x2D, 0x00];
  static final List<int> TEXT_UNDERLINE_ON = [0x1B, 0x2D, 0x01];
  static final List<int> TEXT_UNDERLINE_LARGE = [0x1B, 0x2D, 0x02];

  static final List<int> TEXT_DOUBLE_STRIKE_OFF = [0x1B, 0x47, 0x00];
  static final List<int> TEXT_DOUBLE_STRIKE_ON = [0x1B, 0x47, 0x01];

  static final List<int> TEXT_COLOR_BLACK = [0x1B, 0x72, 0x00];
  static final List<int> TEXT_COLOR_RED = [0x1B, 0x72, 0x01];

  static final List<int> TEXT_COLOR_REVERSE_OFF = [0x1D, 0x42, 0x00];
  static final List<int> TEXT_COLOR_REVERSE_ON = [0x1D, 0x42, 0x01];

  static final int BARCODE_TYPE_UPCA = 65;
  static final int BARCODE_TYPE_UPCE = 66;
  static final int BARCODE_TYPE_EAN13 = 67;
  static final int BARCODE_TYPE_EAN8 = 68;
  static final int BARCODE_TYPE_ITF = 70;
  static final int BARCODE_TYPE_128 = 73;

  static final int BARCODE_TEXT_POSITION_NONE = 0;
  static final int BARCODE_TEXT_POSITION_ABOVE = 1;
  static final int BARCODE_TEXT_POSITION_BELOW = 2;

  static final int QRCODE_1 = 49;
  static final int QRCODE_2 = 50;
}
