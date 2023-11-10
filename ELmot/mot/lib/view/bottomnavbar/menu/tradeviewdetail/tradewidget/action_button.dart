import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.title,
    required this.color,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: foregroundwidget,
      elevation: 0,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: color,
          height: 50.h,
          width: 50.w,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSizes.size11,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
