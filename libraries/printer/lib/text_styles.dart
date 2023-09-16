// import 'package:flutter/widgets.dart';
import 'package:printer/domain/enums/enums.dart';

import 'encoding.dart';

class PrinterTextStyle {
  final TextAlign textAlign;
  final TextColor textColor;
  final TextColorReverse textColorReverse;
  final TextDoubleStrike textDoubleStrike;
  final TextFont textFont;
  final TextSize textSize;
  final TextUnderline textUnderline;
  final TextWeight textWeight;
  final EscPosCharsetEncoding charsetEncoding;
  
  PrinterTextStyle( {
    this.textAlign = TextAlign.textAlignCenter,
    this.textColor = TextColor.textColorBlack,
    this.textDoubleStrike = TextDoubleStrike.textDoubleStrikeOff,
    this.textFont = TextFont.textFontA,
    this.textColorReverse = TextColorReverse.textColorReverseOff,
    this.textSize = TextSize.textSizeNormal,
    this.textUnderline = TextUnderline.textUnderlineOff,
    this.textWeight = TextWeight.textWeightNormal,
    EscPosCharsetEncoding? encoding,
  }):charsetEncoding = encoding ?? EscPosCharsetEncoding(charsetCode: 3, charsetName: "Portuguese");

  PrinterTextStyle copyWith(
      {
      TextAlign? textAlign,  
      TextColor? textColor,
      TextColorReverse? textColorReverse,
      TextDoubleStrike? textDoubleStrike,
      TextFont? textFont,
      TextSize? textSize,
      TextUnderline? textUnderline,
      TextWeight? textWeight,
      EscPosCharsetEncoding? charsetEncoding,}
      ) {
    return PrinterTextStyle(
      textAlign: textAlign ?? this.textAlign,
      textColor: textColor ?? this.textColor,
      textColorReverse: textColorReverse ?? this.textColorReverse,
      textDoubleStrike: textDoubleStrike ?? this.textDoubleStrike,
      textFont: textFont ?? this.textFont,
      textSize: textSize ?? this.textSize,
      textUnderline: textUnderline ?? this.textUnderline,
      textWeight: textWeight ?? this.textWeight,
      encoding: charsetEncoding,
    );
  }
}
