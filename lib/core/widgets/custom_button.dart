import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.onPressed,
    this.btnText,
    this.btnTextStyle,
  });

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final String? btnText;
  final TextStyle? btnTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 42.sp,
      width: width ?? double.infinity,
      child: AppButton(Theme.of(context).platform).build(
        child: Text(
          btnText ?? '',
          style:
              btnTextStyle ??
              TextStyle(fontSize: 16, color: Theme.of(context).secondaryHeaderColor),
          
        ),
        onPressed: onPressed, context: context
      ),
    );
  }
}

abstract class AppButton {
  factory AppButton(TargetPlatform platForm) {
    switch (platForm) {
      case TargetPlatform.android:
        return AndroidButton();
      case TargetPlatform.iOS:
        return IOSButton();
      default:
        return AndroidButton();
    }
  }

  Widget build({required Widget child, VoidCallback? onPressed,required BuildContext context});
}

class AndroidButton implements AppButton {
  @override
  Widget build({required Widget child, VoidCallback? onPressed,required BuildContext context}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: child,
    );
  }
}

// iOS implementation (Cupertino style)
class IOSButton implements AppButton {
  @override
  Widget build({required Widget child, VoidCallback? onPressed,required BuildContext context}) {
    return CupertinoButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: child,
    );
  }
}
