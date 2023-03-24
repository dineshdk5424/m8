import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Helper {
  GradientColor(msg) {
    if (msg == 'select') {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          HexColor('#1F0005'),
          HexColor('#961E39'),
          HexColor('#B82748'),
        ],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.white, Colors.white],
      );
    }
  }
   isvalidElement(data) {
    return data != null;
  }
}
