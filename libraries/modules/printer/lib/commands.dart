// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bitmap/bitmap.dart';
import 'package:printer/domain/errors/printer_erros.dart';
import 'package:printer/text_styles.dart';

import 'domain/connection/device_connection.dart';
import 'domain/enums/enums.dart';
import 'encoding.dart';

class Commands {
  static const int LF = 0x0A;

  static final List<int> RESET_PRINTER = [0x1B, 0x40];

  static final List<int> FEED = [0x1B, 0x4A];

  static final List<int> TEXT_ALIGN_LEFT = [0x1B, 0x61, 0x00];
  static final List<int> TEXT_ALIGN_CENTER = [0x1B, 0x61, 0x01];
  static final List<int> TEXT_ALIGN_RIGHT = [0x1B, 0x61, 0x02];

  // static final List<int> TEXT_WEIGHT_NORMAL = [0x1B, 0x45, 0x00];
  // static final List<int> TEXT_WEIGHT_BOLD = [0x1B, 0x45, 0x01];

  static final List<int> LINE_SPACING_24 = [0x1b, 0x33, 0x18];
  static final List<int> LINE_SPACING_30 = [0x1b, 0x33, 0x1e];

  // static final List<int> TEXT_FONT_A = [0x1B, 0x4D, 0x00];
  // static final List<int> TEXT_FONT_B = [0x1B, 0x4D, 0x01];
  // static final List<int> TEXT_FONT_C = [0x1B, 0x4D, 0x02];
  // static final List<int> TEXT_FONT_D = [0x1B, 0x4D, 0x03];
  // static final List<int> TEXT_FONT_E = [0x1B, 0x4D, 0x04];

  // static final List<int> TEXT_SIZE_NORMAL = [0x1D, 0x21, 0x00];
  // static final List<int> TEXT_SIZE_DOUBLE_HEIGHT = [0x1D, 0x21, 0x01];
  // static final List<int> TEXT_SIZE_DOUBLE_WIDTH = [0x1D, 0x21, 0x10];
  // static final List<int> TEXT_SIZE_BIG = [0x1D, 0x21, 0x11];
  // static final List<int> TEXT_SIZE_BIG_2 = [0x1D, 0x21, 0x22];
  // static final List<int> TEXT_SIZE_BIG_3 = [0x1D, 0x21, 0x33];
  // static final List<int> TEXT_SIZE_BIG_4 = [0x1D, 0x21, 0x44];
  // static final List<int> TEXT_SIZE_BIG_5 = [0x1D, 0x21, 0x55];
  // static final List<int> TEXT_SIZE_BIG_6 = [0x1D, 0x21, 0x66];

  // static final List<int> TEXT_UNDERLINE_OFF = [0x1B, 0x2D, 0x00];
  // static final List<int> TEXT_UNDERLINE_ON = [0x1B, 0x2D, 0x01];
  // static final List<int> TEXT_UNDERLINE_LARGE = [0x1B, 0x2D, 0x02];

  // static final List<int> TEXT_DOUBLE_STRIKE_OFF = [0x1B, 0x47, 0x00];
  // static final List<int> TEXT_DOUBLE_STRIKE_ON = [0x1B, 0x47, 0x01];

  // static final List<int> TEXT_COLOR_BLACK = [0x1B, 0x72, 0x00];
  // static final List<int> TEXT_COLOR_RED = [0x1B, 0x72, 0x01];

  // static final List<int> TEXT_COLOR_REVERSE_OFF = [0x1D, 0x42, 0x00];
  // static final List<int> TEXT_COLOR_REVERSE_ON = [0x1D, 0x42, 0x01];

  static const int BARCODE_TYPE_UPCA = 65;
  static const int BARCODE_TYPE_UPCE = 66;
  static const int BARCODE_TYPE_EAN13 = 67;
  static const int BARCODE_TYPE_EAN8 = 68;
  static const int BARCODE_TYPE_ITF = 70;
  static const int BARCODE_TYPE_128 = 73;

  static const int BARCODE_TEXT_POSITION_NONE = 0;
  static const int BARCODE_TEXT_POSITION_ABOVE = 1;
  static const int BARCODE_TEXT_POSITION_BELOW = 2;

  static const int QRCODE_1 = 49;
  static const int QRCODE_2 = 50;

  final DeviceConnection printerConnection;
  final EscPosCharsetEncoding charsetEncoding;
  final bool useEscAsteriskCommand;
  final PrinterTextStyle printerTextStyle;

  Commands({
    required this.printerConnection,
    required this.charsetEncoding,
    required this.useEscAsteriskCommand,
    PrinterTextStyle? textStyle,
  }) : printerTextStyle = textStyle ?? PrinterTextStyle();

  void printQRCode(
    String text, {
    int dotSize = 1,
    int qrCodeType = QRCODE_1,
  }) {
    var size = dotSize;
    if (!printerConnection.isConnected()) {
      throw PrinterError(
        StackTrace.current,
        "PrintModule",
        "",
        "Printer Not Connected",
      );
    }

    if (size < 1) {
      size = 1;
    } else if (size > 16) {
      size = 16;
    }

    try {
      final textBytes = utf8.encode(text);

      final commandLength = textBytes.length + 3,
          pL = commandLength % 256,
          pH = (commandLength / 256) as int;

      printerConnection
        ..write([0x1D, 0x28, 0x6B, 0x04, 0x00, 0x31, 0x41, qrCodeType, 0x00])
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x43, size])
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x45, 0x30]);

      final qrCodeCommand = <int>[]
        ..addAll([0x1D, 0x28, 0x6B, pL, pH, 0x31, 0x50, 0x30])
        ..addAll(textBytes);

      printerConnection
        ..write(qrCodeCommand)
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x51, 0x30]);
    } catch (e, s) {
      PrinterError(s, "Printer-Error-PrintQRCode", e, e.toString());
    }
    // return this;
  }

  Future<void> printBitmap(Bitmap image, {bool gradient = false}) async {
    // ByteData imageBytes = await rootBundle.load(imgSrc);
    // List<int> values = imageBytes.buffer.asUint8List();

    final bitmapWidth = image.width,
        bitmapHeight = image.height,
        bytesByLine = (bitmapWidth / 8).ceil(),
        xH = bytesByLine ~/ 256,
        xL = bytesByLine - (xH * 256),
        yH = bitmapHeight ~/ 256,
        yL = bitmapHeight - (yH * 256);

    final imageBytes = <int>[0x1D, 0x76, 0x30, 0x00, xL, xH, yL, yH];

    const gradientStep = 6,
        colorLevelStep = 765.0 / (15 * gradientStep + gradientStep - 1);
    var i = 8, greyscaleCoefficientInit = 0;

    for (var posY = 0; posY < bitmapHeight; posY++) {
      var greyscaleCoefficient = greyscaleCoefficientInit,
          greyscaleLine = posY % gradientStep;
      for (var j = 0; j < bitmapWidth; j += 8) {
        var b = 0;
        for (var k = 0; k < 8; k++) {
          final posX = j + k;
          if (posX < bitmapWidth) {
            final color = image.content[posX + (posY * image.width)],
                red = (color >> 16) & 255,
                green = (color >> 8) & 255,
                blue = color & 255;

            if ((gradient &&
                    (red + green + blue) <
                        ((greyscaleCoefficient * gradientStep + greyscaleLine) *
                            colorLevelStep)) ||
                (!gradient && (red < 160 || green < 160 || blue < 160))) {
              b |= 1 << (7 - k);
            }

            greyscaleCoefficient += 5;
            if (greyscaleCoefficient > 15) {
              greyscaleCoefficient -= 16;
            }
          }
        }
        imageBytes[i++] = b;
      }

      greyscaleCoefficientInit += 2;
      if (greyscaleCoefficientInit > 15) {
        greyscaleCoefficientInit = 0;
      }
    }
  }

  List<int> genListStyles(PrinterTextStyle printerTextStyle) {
    return <int>[]
      ..addAll(printerTextStyle.textFont.value)
      ..addAll(printerTextStyle.textSize.value)
      ..addAll(printerTextStyle.textDoubleStrike.value)
      ..addAll(printerTextStyle.textUnderline.value)
      ..addAll(printerTextStyle.textWeight.value)
      ..addAll(printerTextStyle.textColor.value)
      ..addAll(printerTextStyle.textColorReverse.value)

      ;
  }

  List<int> addTextStyle(PrinterTextStyle? printerTextStyle) {
    final bytes = <int>[];

    printerTextStyle != null
        ? bytes.addAll(genListStyles(printerTextStyle))
        : bytes.addAll(genListStyles(this.printerTextStyle));

    return bytes;
  }

  void printText(String text, [PrinterTextStyle? printerTextStyle]) {
    if (!printerConnection.isConnected()) {
      throw PrinterError(StackTrace.current, "PrinterModule-PrintText", "", "Printer Not Connected");
    }

    try {
      final textBytes = utf8.encode(text); //change to another
      printerConnection
        ..write(charsetEncoding.charsetCommand)
        ..write(addTextStyle(printerTextStyle))
        ..write(textBytes);
    } catch (e, s) {
      throw PrinterError(s, "PrinterModule-PrintText", e, e.toString());
    }

    // return this;
  }
}
