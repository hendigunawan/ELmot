import 'package:flutter/material.dart';
import 'package:k_chart/flutter_k_chart.dart';

class ChartWidgetDaily extends StatelessWidget {
  final List<KLineEntity> mapData;
  const ChartWidgetDaily({super.key, required this.mapData});

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
