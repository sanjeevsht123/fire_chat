import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetX on Widget {
  Padding px(double padding) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: this,
  );

  Padding pB(double padding) => Padding(
    padding: EdgeInsets.only(bottom: padding),
    child: this,
  );

  Padding pT(double padding) => Padding(
    padding: EdgeInsets.only(top: padding),
    child: this,
  );

  Padding pR(double padding) => Padding(
    padding: EdgeInsets.only(right: padding),
    child: this,
  );

  Padding pL(double padding) => Padding(
    padding: EdgeInsets.only(left: padding),
    child: this,
  );

  /// default horizontal spacing
  Padding get pXScreenDefault => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: this,
  );

  /// medium horizontal spacing
  Padding get pXScreenMedium => Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: this,
  );

  ///  vertical | horizontal spacing
  Padding pXY(double x, double y) => Padding(
    padding: EdgeInsets.symmetric(horizontal: x, vertical: y),
    child: this,
  );
  Padding py(double padding) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: this,
  );

  Padding pOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding:
        EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
        child: this,
      );

  Padding padAll(double value) => Padding(
    padding: EdgeInsets.all(value),
    child: this,
  );
}