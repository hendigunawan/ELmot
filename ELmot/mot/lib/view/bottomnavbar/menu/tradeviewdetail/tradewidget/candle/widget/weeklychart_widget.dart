import 'package:flutter/material.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/renderer/main_renderer.dart';

class WeeklyChartWidget extends StatelessWidget {
  final List<KLineEntity> mapData;
  const WeeklyChartWidget({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return KChartWidget(
      mapData,
      ChartStyle(), ChartColors(),
      secondaryState: SecondaryState.NONE,
      mainState: MainState.MA,
      isTrendLine: false,
      timeFormat: TimeFormat.YEAR_MONTH_DAY,
      volHidden: false,
      flingTime: 100,
      verticalTextAlignment: VerticalTextAlignment.right,
      // isTapShowInfoDialog: true,
    );
  }
}
