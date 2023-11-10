import 'package:flutter/cupertino.dart';

double getContainerWidth(BuildContext context) {
  // Menentukan lebar container berdasarkan lebar layar
  // Di sini, container akan menempati 80% lebar layar untuk perangkat dengan lebar > 600, dan 90% untuk perangkat dengan lebar <= 600
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth > 600 ? screenWidth * 0.8 : screenWidth * 0.9;
}

double getContainerHeight(BuildContext context) {
  // Menentukan tinggi container berdasarkan tinggi layar
  // Di sini, container akan menempati 200 piksel untuk perangkat dengan tinggi > 600, dan 150 piksel untuk perangkat dengan tinggi <= 600
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight > 600 ? 200 : 150;
}
