import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatefulWidget {
  final String text;

  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final Icon? icon;

  final ButtonType type;

  const Button(this.text,
      {Key? key,
      required this.onPressed,
      required this.type,
      required this.borderRadius,
      this.width = 200,
      this.height,
      this.icon})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ButtonState(
        text, onPressed, type, borderRadius, width?.w, height?.w, icon);
  }
}

class _ButtonState extends State {
  final String text;
  final VoidCallback onPressed;

  final ButtonType type;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final Icon? icon;

  _ButtonState(this.text, this.onPressed, this.type, this.borderRadius,
      this.width, this.height, this.icon);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        {
          return _getPrimaryButton(
              text, onPressed, borderRadius, width, height);
        }
      case ButtonType.secondary:
        {
          return _getSecondarButton(
              text, onPressed, borderRadius, width, height);
        }
      case ButtonType.destructive:
        {
          return _getDestructiveButton(
              text, onPressed, borderRadius, width, height);
        }
      case ButtonType.withIcon:
        {
          return _getWithIconButton(
              text, onPressed, borderRadius, width, height, icon);
        }
      case ButtonType.forgetPassword:
        {
          return _getForgetPassword(
              text, onPressed, borderRadius, width, height);
        }
      default:
        {
          return _getDefaultButton(
              text, onPressed, borderRadius, width, height);
        }
    }
  }

  Widget _getWithIconButton(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
    Icon? icon,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(color: WHITE_COLOR),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: const BorderSide(
              color: BORDER_COLOR, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 12.h, end: 16.w, bottom: 12.h),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: icon,
        ),
      ),
    );
  }

  Widget _getDefaultButton(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: WHITE_COLOR, fontSize: 17.sp),
        backgroundColor: DEFAULT_COLOR,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: const BorderSide(
              color: BORDER_COLOR, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 12.h, end: 16.w, bottom: 12.h),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget _getPrimaryButton(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(color: WHITE_COLOR),
        backgroundColor: BLUE_COLOR,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
              color: BORDER_COLOR, width: 1.w, style: BorderStyle.solid),
        ),
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 12.h, end: 16.w, bottom: 12.h),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget _getSecondarButton(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(color: WHITE_COLOR),
        backgroundColor: WHITE_COLOR,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
              color: BORDER_COLOR, width: 1.w, style: BorderStyle.solid),
        ),
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 12.h, end: 16.w, bottom: 12.h),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: TEXT_BLACK,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget _getDestructiveButton(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(color: WHITE_COLOR),
        backgroundColor: RED_COLOR,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(
              color: BORDER_COLOR, width: 1.w, style: BorderStyle.solid),
        ),
        padding: EdgeInsetsDirectional.only(
            start: 16.w, top: 12.h, end: 16.w, bottom: 12.h),
      ),
      child: SizedBox(
        width: width?.w,
        height: height?.w,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget _getForgetPassword(
    String text,
    VoidCallback onPressed,
    BorderRadius borderRadius,
    double? width,
    double? height,
  ) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(0, 49, 49, 49)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent)

            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   shadowColor: Colors.transparent

            ),
        child: SizedBox(
          width: width!.toInt().w,
          height: height,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
              softWrap: false,
            ),
          ),
        ));
  }
}

enum ButtonType {
  // the enum values
  withIcon,
  defaults,
  primary,
  secondary,
  destructive,
  forgetPassword
}

const TEXT_BLACK = Color(0xFF202020);
const WHITE_COLOR = Color(0xFFffffff);
const BLUE_COLOR = Color(0xFF3d85cd);
const RED_COLOR = Color(0xFFfc2b2b);
const BORDER_COLOR = Color(0xFFdadada);
const DEFAULT_COLOR = Color.fromARGB(255, 129, 129, 129);
