// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

extension NumX on num {
  Duration get microSeconds => Duration(microseconds: toInt());

  Duration get milliSeconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get minutes => Duration(minutes: toInt());

  Duration get hour => Duration(hours: toInt());

  Future<dynamic> get delayedMicroSeconds async =>
      Future.delayed(toInt().microSeconds);

  Future<dynamic> get delayedMilliSeconds async =>
      Future.delayed(toInt().milliSeconds);

  Future<dynamic> get delayedSeconds async => Future.delayed(toInt().seconds);

  Future<dynamic> get delayedHour async => Future.delayed(toInt().hour);

  EdgeInsets get all => EdgeInsets.all(toDouble());

  Radius get circular => Radius.circular(toDouble());

  BorderRadiusGeometry get rounded => BorderRadius.circular(toDouble());

  // to currenty
  String get toCurrency => toDouble().toStringAsFixed(2);

  // isNumericOnly
  bool get isNumericOnly => RegExp(r'^-?[0-9]+$').hasMatch(toString());
}
