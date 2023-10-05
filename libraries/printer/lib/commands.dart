// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';
import 'package:bitmap/bitmap.dart';
import 'package:flutter/foundation.dart';
import 'package:printer/domain/enums/printer_size.dart';
import 'package:printer/domain/errors/printer_erros.dart';
import 'package:printer/text_styles.dart';

import 'domain/connection/device_connection.dart';
import 'domain/entities/table_item.dart';
import 'domain/enums/text_align.dart';

class PrinterCommands {
  static const int LF = 0x0A;

  static final List<int> RESET_PRINTER = [0x1B, 0x40];

  static final List<int> FEED = [0x1B, 0x4A];

  static final List<int> LINE_SPACING_24 = [0x1b, 0x33, 0x18];
  static final List<int> LINE_SPACING_30 = [0x1b, 0x33, 0x1e];

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
  final PrinterTextStyle defaultPrinterTextStyle;
  final PrinterSize printerSize;

  PrinterCommands({
    required this.printerConnection,
    PrinterTextStyle? textStyle,
    this.printerSize = PrinterSize.eightyMM,
  }) : defaultPrinterTextStyle = textStyle ?? PrinterTextStyle() {
    connect();
  }

  Future<void> connect() async {
    try {
      await printerConnection.connect();
      reset();
    } catch (e, s) {
      throw PrinterError(
        s,
        "PrinterModule-connect",
        e,
        "Unable To Connect to Printer",
      );
    }
  }

  void printQRCode(String text,
      {int dotSize = 16,
      int qrCodeType = QRCODE_2,
      PrinterTextStyle? printerTextStyle}) {
    printerTextStyle ??= defaultPrinterTextStyle;
    if (!printerConnection.isConnected()) {
      return;
    }

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
          pH = (commandLength / 256).floor();

      printerConnection
        ..write([0x1D, 0x28, 0x6B, 0x04, 0x00, 0x31, 0x41, qrCodeType, 0x00])
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x43, size])
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x45, 0x30]);

      final qrCodeCommand = <int>[]
        ..addAll([0x1D, 0x28, 0x6B, pL, pH, 0x31, 0x50, 0x30])
        ..addAll(textBytes);

      printerConnection
        ..write(genListStyles(printerTextStyle))
        ..write(qrCodeCommand)
        ..write([0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x51, 0x30])
        ..send();
    } catch (e, s) {
      PrinterError(s, "Printer-Error-PrintQRCode", e, e.toString());
    }
    // return this;
  }

  List<int> initImage(int bytesByLine, int bitmapHeight) {
    final xH = bytesByLine ~/ 256,
        xL = bytesByLine - (xH * 256),
        yH = bitmapHeight ~/ 256,
        yL = bitmapHeight - (yH * 256);

    return <int>[0x1D, 0x76, 0x30, 0x00, xL, xH, yL, yH];
  }

  Future<void> printBitmap(Bitmap image, {bool gradient = false}) async {
    if (!printerConnection.isConnected()) {
      return;
    }

    final bitmapWidth = image.width,
        bitmapHeight = image.height,
        bytesByLine = (bitmapWidth / 8).ceil();

    var imageBytes = initImage(bytesByLine, bitmapHeight);

    const gradientStep = 6,
        colorLevelStep = 765.0 / (15 * gradientStep + gradientStep - 1);
    var greyscaleCoefficientInit = 0;

    for (var posY = 0; posY < bitmapHeight; posY++) {
      var greyscaleCoefficient = greyscaleCoefficientInit,
          greyscaleLine = posY % gradientStep;
      for (var j = 0; j < bitmapWidth; j += 8) {
        var b = 0;
        for (var k = 0; k < 8; k++) {
          final posX = j + k;
          if (posX < bitmapWidth) {
            final color = image.content[posX + (posY * bitmapWidth)],
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
        imageBytes.add(b);
      }

      greyscaleCoefficientInit += 2;
      if (greyscaleCoefficientInit > 15) {
        greyscaleCoefficientInit = 0;
      }
    }

    // late final List<int> newImage;

    final printerSize = 80,
        nbrByteDiff = ((printerSize - bitmapWidth) / 8).round(),
        nbrWhiteByteToInsert = (nbrByteDiff / 2).round();

    if (nbrWhiteByteToInsert > 0) {
      final newByteWidth = bytesByLine + nbrWhiteByteToInsert;
      final newImage = initImage(newByteWidth, bitmapHeight);
      for (var i = 0; i < bitmapHeight; i++) {
        newImage.add(imageBytes[bytesByLine * i + 8]);
      }
      imageBytes = newImage;
    }

    printerConnection
      ..write(TextAlign.textAlignRight.value)
      ..write(imageBytes)
      ..send();
  }

  List<int> genListStyles(PrinterTextStyle printerTextStyle) {
    return <int>[]
      ..addAll(printerTextStyle.charsetEncoding.charsetCommand)
      ..addAll(printerTextStyle.textAlign.value)
      ..addAll(printerTextStyle.textFont.value)
      ..addAll(printerTextStyle.textSize.value)
      ..addAll(printerTextStyle.textDoubleStrike.value)
      ..addAll(printerTextStyle.textUnderline.value)
      ..addAll(printerTextStyle.textWeight.value)
      ..addAll(printerTextStyle.textColor.value)
      ..addAll(printerTextStyle.textColorReverse.value);
  }

  void printText(String text, [PrinterTextStyle? printerTextStyle]) {
    printerTextStyle ??= defaultPrinterTextStyle;
    if (!printerConnection.isConnected()) {
      return;
    }

    try {
      // final textBytes = latin1.encode(text.replaceAll(RegExp(r'[^\x00-\xFC]+'), " ")); //change to another
      final textBytes = latin1.encode(text); //change to another

      printerConnection
        ..write(genListStyles(printerTextStyle))
        ..write(textBytes);
    } catch (e, s) {
      debugPrint(e.toString());
      throw PrinterError(s, "PrinterModule-PrintText", e, e.toString());
    }

    // return this;
  }

  void testPrinter() {
    printerConnection
      ..write(genListStyles(defaultPrinterTextStyle))
      ..write(
        utf8.encode(
          ":::: Charset n°${defaultPrinterTextStyle.charsetEncoding.charsetCode} : ",
        ),
      )
      ..write(
        [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A],
      )
      ..write(
        [0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15],
      )
      ..write(
        [0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20],
      )
      ..write(
        [0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B],
      )
      ..write(
        [0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36],
      )
      ..write(
        [0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x41],
      )
      ..write(
        [0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C],
      )
      ..write(
        [0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57],
      )
      ..write(
        [0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x62],
      )
      ..write(
        [0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D],
      )
      ..write(
        [0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78],
      )
      ..write(
        [0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F, 0x80, 0x81, 0x82, 0x83],
      )
      ..write(
        [0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E],
      )
      ..write(
        [0x8F, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99],
      )
      ..write(
        [0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F, 0xA0, 0xA1, 0xA2, 0xA3, 0xA4],
      )
      ..write(
        [0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF],
      )
      ..write(
        [0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA],
      )
      ..write(
        [0xBB, 0xBC, 0xBD, 0xBE, 0xBF, 0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5],
      )
      ..write(
        [0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF, 0xD0],
      )
      ..write(
        [0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB],
      )
      ..write(
        [0xDC, 0xDD, 0xDE, 0xDF, 0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6],
      )
      ..write(
        [0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF, 0xF0, 0xF1],
      )
      ..write(
        [0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC],
      )
      ..write([0xFD, 0xFE, 0xFF])
      ..write([LF, LF, LF, LF])
      ..send();
  }

  void feedPaper(int dots) {
    if (!printerConnection.isConnected()) {
      return;
    }

    if (dots > 0 && dots < 256) {
      printerConnection
        ..write([0x1B, 0x4A, dots])
        ..send(addWaitingTime: dots);
    }
  }

  void cutPaper({int lines = 3}) {
    if (!printerConnection.isConnected()) {
      return;
    }

    printerConnection
      ..write(List.generate(lines, (index) => "\n").join().codeUnits)
      ..write([0x1D, 0x56, 0x01])
      ..send(addWaitingTime: 100);
  }

  void reset() {
    if (!printerConnection.isConnected()) {
      return;
    }
    printerConnection.write(RESET_PRINTER);
    return;
  }

  void disconnect() {
    if (printerConnection.isConnected()) printerConnection.disconnect();
  }

  // fixed size columns
  void printTable(List<TableItem> table, [PrinterTextStyle? printerTextStyle]) {
    printerTextStyle ??= defaultPrinterTextStyle;
    final totalColumnsSize = table.fold(
        0, (previousValue, element) => element.columns + previousValue);
    if (totalColumnsSize > printerTextStyle.textFont.columns) {
      throw PrinterError(StackTrace.current, "PrinterModule-printTable", "",
          "Total Columns size Exceeded");
    }
    final wrappedText = StringBuffer();
    for (final element in table) {
      final parsedElement =
          element.text.replaceAll(RegExp(r'[^\x00-\xFC]+'), "");
      final totalAvailable =
          calculateMaxChar(printerTextStyle, element.columns);
      if (parsedElement.length > totalAvailable) {
        wrappedText.write(parsedElement.substring(0, totalAvailable));
      } else {
        // final difference = totalAvailable - parsedElement.length;
        wrappedText.write(parsedElement.padRight(totalAvailable));
      }
    }
    printText("$wrappedText\n");
  }

  void printRow(List<String> texts,
      [PrinterTextStyle? printerTextStyle, int spacing = 2]) {
    printerTextStyle ??= defaultPrinterTextStyle;

    var totalSize = spacing;
    final parsedText = texts.map((e) {
      final text = e.replaceAll(RegExp(r'[^\x00-\xFC]+'), "");
      totalSize += text.length;
      return text;
    }).toList();

    final totalAvailable = calculateMaxCharPerRoW(printerTextStyle);

    final wrappedText = StringBuffer();
    // define if will be needed any additional parameter for padding
    if (totalAvailable > totalSize &&
            printerTextStyle.textAlign == TextAlign.textAlignRight ||
        printerTextStyle.textAlign == TextAlign.textAlignLeft) {
      final remaining = (totalAvailable - totalSize) + spacing;
      debugPrint(remaining.toString());
      if (parsedText.isNotEmpty)
        wrappedText
            .write(parsedText[0].padRight(parsedText[0].length + remaining));
      for (var i = 1; i < parsedText.length && parsedText.length > 1; i++) {
        wrappedText.write(parsedText[i]);
      }
    } else {
      for (final text in parsedText) {
        wrappedText.write(text.padRight(2));
      }
    }

    printText("$wrappedText\n", printerTextStyle);
  }

  void printHR() {
    final totalAvailable = calculateMaxCharPerRoW(defaultPrinterTextStyle);
    final spacer = utf8.encode("".padRight(totalAvailable, "-"));

    printerConnection
      ..write(genListStyles(defaultPrinterTextStyle))
      ..write(spacer)
      ..send();
  }

  int calculateMaxCharPerRoW(PrinterTextStyle textStyle) {
    return (textStyle.textFont.columns / textStyle.textSize.size).floor();
  }

  int calculateMaxChar(PrinterTextStyle textStyle, int columns) {
    return (columns / textStyle.textSize.size).floor();
  }

  int calculateColumns(PrinterTextStyle textStyle, int chars) {
    return (chars * textStyle.textSize.size).floor();
  }
}
