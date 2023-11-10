import 'package:flutter/material.dart';
import 'package:online_trading/helper/constant_style.dart';

Color Colorss(int? price, int? prev) {
  if (prev == null || price == null) {
    return putihop85;
  } else if (price == 0) {
    return putihop85;
  } else if (price > prev) {
    return Colors.green;
  } else if (price < prev) {
    return Colors.red;
  } else if (price == prev) {
    return const Color.fromARGB(255, 252, 227, 3);
  } else {
    return Colors.blue;
  }
}

Color ColorsAvg(double? price, double? prev) {
  if (prev == null || price == null) {
    return Colors.white;
  } else if (price == 0) {
    return Colors.white;
  } else if (price > prev) {
    return Colors.green;
  } else if (price < prev) {
    return Colors.red;
  } else if (price == prev) {
    return const Color.fromARGB(255, 252, 227, 3);
  } else {
    return Colors.blue;
  }
}
