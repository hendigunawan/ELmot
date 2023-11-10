import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class PopUpTralingMenu {
  static List<PopupMenuEntry> listPopUp({bool type = true}) {
    return [
      PopupMenuItem(
        height: 30.h,
        value: 0,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'}',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 1,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'} +1',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 2,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'} +2',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 3,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'} +3',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 4,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'} +4',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 5,
        child: Text(
          'Best ${type ? 'Offer' : 'Bid'} +5',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
    ];
  }

  static List<PopupMenuEntry> listPopUpTypePrice() {
    return [
      PopupMenuItem(
        height: 30.h,
        value: 0,
        child: Text(
          'Best Bid Price',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 1,
        child: Text(
          'Best Offer Price',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 2,
        child: Text(
          'Last Price',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 2,
        child: Text(
          'Avg Price',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
      PopupMenuItem(
        height: 30.h,
        value: 3,
        child: Text(
          'High Price',
          style: TextStyle(fontSize: FontSizes.size12),
        ),
      ),
    ];
  }
}
