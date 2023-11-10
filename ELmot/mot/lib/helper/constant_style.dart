import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantStyle {
  static Color oren = const Color.fromARGB(255, 163, 124, 8);

  static Color foreground = const Color.fromARGB(251, 25, 25, 25);
  static Color backgroundhitam = Colors.black;
  static Color titletextcolors = const Color.fromARGB(255, 206, 160, 22);
  static double ukurantitle = 0.05;
  static Color primaryColor = const Color(0xFF2967FF);
  static Color grayColor = const Color(0xFF8D8D8E);
  static double defaultPadding = 16.0;
}

Color backgroundwidget = const Color.fromARGB(255, 39, 39, 46);
Color foregroundwidget = const Color.fromARGB(255, 46, 46, 52);
Color colorbaru = const Color.fromARGB(255, 51, 55, 61);
Color foregroundwidget2 = const Color.fromARGB(255, 116, 116, 121);
Color bgabu = const Color.fromARGB(255, 22, 22, 26);
Color highlightShimmer = const Color.fromARGB(255, 34, 34, 34);
Color greenOn = const Color.fromARGB(255, 26, 114, 29);
Color barubiru = const Color.fromARGB(255, 137, 185, 255);
Color putihop85 = Colors.white.withOpacity(0.85);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;
Color bgabu2 = const Color.fromRGBO(20, 20, 20, 1);

class SizeE {
// constans style
  static double heightTransformers(BuildContext context) {
    return context.heightTransformer();
  }

  static double widthTransformers(BuildContext context) {
    return context.widthTransformer();
  }

  static double devicePixelRation(BuildContext context) {
    return context.devicePixelRatio;
  }

  static double textScaleFactors(BuildContext context) {
    return context.textScaleFactor;
  }

  static double mediaQueryShortestSides(BuildContext context) {
    return context.mediaQueryShortestSide;
  }
}
