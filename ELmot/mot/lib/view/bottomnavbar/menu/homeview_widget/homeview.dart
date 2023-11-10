import 'package:flutter/material.dart';
import 'appbarwidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: SizedBox(
        height: double.infinity,
        child: WidgetAppBarHome(),
      ),
    );
  }
}
