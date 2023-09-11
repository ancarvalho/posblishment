import 'package:printer/domain/enums/enums.dart';

class PrinterTextStyle {
  final TextColor textColor;
  final TextColorReverse textColorReverse;
  final TextDoubleStrike textDoubleStrike;
  final TextFont textFont;
  final TextSize textSize;
  final TextUnderline textUnderline;
  final TextWeight textWeight;

  PrinterTextStyle({
    this.textColor = TextColor.textColorBlack,
    this.textDoubleStrike = TextDoubleStrike.textDoubleStrikeOff,
    this.textFont = TextFont.textFontA,
    this.textColorReverse = TextColorReverse.textColorReverseOff,
    this.textSize = TextSize.textSizeNormal,
    this.textUnderline = TextUnderline.textUnderlineOff,
    this.textWeight = TextWeight.textWeightNormal,
  });



  PrinterTextStyle copyWith(
      TextColor? textColor,
      TextColorReverse? textColorReverse,
      TextDoubleStrike? textDoubleStrike,
      TextFont? textFont,
      TextSize? textSize,
      TextUnderline? textUnderline,
      TextWeight? textWeight) {
    return PrinterTextStyle(
      textColor: textColor ?? this.textColor,
      textColorReverse: textColorReverse ?? this.textColorReverse,
      textDoubleStrike: textDoubleStrike ?? this.textDoubleStrike,
      textFont: textFont ?? this.textFont,
      textSize: textSize ?? this.textSize,
      textUnderline: textUnderline ?? this.textUnderline,
      textWeight: textWeight ?? this.textWeight,
    );
  }
}