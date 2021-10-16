import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle getTextStyleWhiteNormalText({bool? isBold, Color? color}) {
    if (isBold == null) {
      isBold = false;
    }

    Color? _color;
    if (color != null) {
      _color = color;
    } else {
      _color = Colors.white;
    }

    if (isBold) {
      return new TextStyle(color: _color, fontWeight: FontWeight.bold);
    } else {
      return new TextStyle(color: _color);
    }
  }

  static TextStyle getTextStyleWhiteHeaderText({Color? color}) {
    if (color != null) {
      return new TextStyle(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );
    }
    return new TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);
  }

  static TextStyle getTextStyleWhiteTitleText({Color? color}) {
    if (color != null) {
      return new TextStyle(
          color: color, fontSize: 22, fontWeight: FontWeight.bold);
    }
    return new TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
  }

  //   static TextStyle getTextStyleWhiteTitleText({Color? color, int? textSize}) {
  //   if (color != null) {
  //     return new TextStyle(
  //         color: color, fontSize: 22, fontWeight: FontWeight.bold);
  //   }
  //   return new TextStyle(
  //       color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
  // }

  static TextStyle getTextStyleWhiteSubTitleText({Color? color}) {
    if (color != null) {
      return new TextStyle(color: color, fontSize: 12);
    }
    return new TextStyle(color: Colors.white, fontSize: 12);
  }

  static TextStyle getTextStyleHintText() {
    return new TextStyle(color: Colors.black26, fontSize: 10);
  }
}
