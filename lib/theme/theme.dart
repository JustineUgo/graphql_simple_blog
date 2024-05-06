import 'package:flutter/material.dart';

extension GithubExtension on BuildContext {
  TextStyle get textStyle => const TextStyle(fontSize: 16, color: Colors.white);
}

class Sizes {
  static const baseNone = 0.00;
  static const baseQuarter = 2.00;
  static const baseHalf = 4.00;
  static const baseSingle = 8.00;
  static const baseSingleQuarter = 10.00;
  static const baseSingleHalf = 12.00;
  static const baseDouble = 16.00;
  static const baseDoubleQuarter = 18.00;
  static const baseDoubleHalf = 20.00;
  static const baseTriple = 24.00;
  static const baseQuadruple = 32.00;
  static const baseQuadrupleHalf = 36.00;
  static const baseFivefold = 40.00;
}
