import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:online_trading/module/model/dailychartdata_model.dart';
import 'package:online_trading/module/model/monthlychartdata_model.dart';
import 'package:online_trading/module/model/weeklychartdata_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/widget/dailychart_widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/widget/monthly_widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/widget/weeklychart_widget.dart';

enum ChartType {
  daily,
  weekly,
  monthly,
}

class ChartComponent extends StatelessWidget {
  final String stockCode;
  final ChartType type;
  final String? board;
  final List<KLineEntity>? data;
  const ChartComponent({
    super.key,
    required this.type,
    required this.stockCode,
    this.board,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ChartType.daily:
        {
          return ChartWidgetDaily(
            mapData: data!,
          );
        }
      case ChartType.weekly:
        {
          return WeeklyChartWidget(
            mapData: data!,
          );
        }
      case ChartType.monthly:
        {
          return MonthlyChartWidget(
            mapData: data!,
          );
        }
      default:
        {
          return const Center();
        }
    }
  }
}

int date(String data) {
  int year = int.parse(data.substring(0, 4));
  int month = int.parse(data.substring(4, 6));
  int day = int.parse(data.substring(6, 8));
  String dateTime =
      DateTime(year, month, day).millisecondsSinceEpoch.toString();
  int datas = int.parse(dateTime);
  return datas;
}

String dateAja(dynamic datas) {
  String data = datas.toString();
  int year = int.parse(data.substring(0, 4));
  int month = int.parse(data.substring(4, 6));
  int day = int.parse(data.substring(6, 8));
  String dateTime =
      ("$year-${(month.toString().length == 1 ? '0$month' : month)}-${(day.toString().length == 1 ? '0$day' : day)}")
          .toString();
  return dateTime;
}

String dateAjaGarisMiring(dynamic datas) {
  if (datas == null) {
    return '';
  }
  String data = datas.toString();
  int year = int.parse(data.substring(0, 4));
  int month = int.parse(data.substring(4, 6));
  int day = int.parse(data.substring(6, 8));
  String dateTime =
      ("$year/${(month.toString().length == 1 ? '0$month' : month)}/${(day.toString().length == 1 ? '0$day' : day)}")
          .toString();

  return dateTime;
}

String dateAjaGarisMiringWithDay(dynamic datas) {
  String data = datas.toString();
  int year = int.parse(data.substring(0, 4));
  int month = int.parse(data.substring(4, 6));
  int day = int.parse(data.substring(6, 8));

  String datar =
      DateFormat('yyyy/MM/dd, EEEE').format(DateTime(year, month, day));
  return datar;
}

String dateTimeAJa(dynamic data) {
  String timeString = data.toString();
  if (timeString == '0') {
    return '';
  }
  if (timeString.length == 5) {
    timeString = '0$timeString';
  }
  int hours = int.parse(timeString.substring(0, 2));
  int minutes = int.parse(timeString.substring(2, 4));
  int seconds = int.parse(timeString.substring(4, 6));
  Duration duration =
      Duration(hours: hours, minutes: minutes, seconds: seconds);
  String formattedTime =
      '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  return formattedTime;
}

class CandleList {
  static List<KLineEntity> generateList(List<ArrayDailyChartData> datas) {
    List<ArrayDailyChartData> data = List.filled(
      datas.length,
      ArrayDailyChartData(
        closePrice: 0,
        date: int.parse(
            DateFormat("yyyyMMddHHkkmm", 'en_US').format(DateTime.now())),
        openPrice: 0,
        highPrice: 0,
        lowPrice: 0,
        freq: 0,
        value: 0,
        volume: 0,
      ),
    );
    int ins = 0;
    for (var element in datas) {
      if (ins < datas.length) {
        data[ins] = element;
        ins++;
      }
    }
    var sorts = data..sort((a, b) => a.date!.compareTo(b.date!));

    return List.generate(
      sorts.length,
      (index) => KLineEntity.fromCustom(
        close: sorts[index].closePrice!.toInt().toDouble(),
        time: date(sorts[index].date!.toString()),
        open: sorts[index].openPrice!.toInt().toDouble(),
        vol: sorts[index].volume!.toInt().toDouble(),
        high: sorts[index].highPrice!.toInt().toDouble(),
        low: sorts[index].lowPrice!.toInt().toDouble(),
      ),
    ).toList();
  }

  static Stream<List<DailyChartDataModel>> getDaily(
      String stockCode, String board) {
    final open = ObjectBoxDatabase.dailyChartDataBox;
    final stream = open.query(
      DailyChartDataModel_.stockCode.equals(stockCode) &
          DailyChartDataModel_.board.equals(board),
    )..order(DailyChartDataModel_.id, flags: Order.caseSensitive);
    return stream.watch(triggerImmediately: true).map((event) => event.find());
  }
}

class CandleListWeekly {
  static List<KLineEntity> generateList(List<ArrayWeeklyChartData> datas) {
    List<ArrayWeeklyChartData> data = List.filled(
      datas.length,
      ArrayWeeklyChartData(
        closePrice: 0,
        date: int.parse(
            DateFormat("yyyyMMddHHkkmm", 'en_US').format(DateTime.now())),
        openPrice: 0,
        highPrice: 0,
        lowPrice: 0,
        freq: 0,
        value: 0,
        volume: 0,
      ),
    );
    int ins = 0;
    for (var element in datas) {
      if (ins < datas.length) {
        data[ins] = element;
        ins++;
      }
    }
    var sorts = data..sort((a, b) => a.date!.compareTo(b.date!));

    return List.generate(
      sorts.length,
      (index) => KLineEntity.fromCustom(
        close: sorts[index].closePrice!.toInt().toDouble(),
        time: date(sorts[index].date!.toString()),
        open: sorts[index].openPrice!.toInt().toDouble(),
        vol: sorts[index].volume!.toInt().toDouble(),
        high: sorts[index].highPrice!.toInt().toDouble(),
        low: sorts[index].lowPrice!.toInt().toDouble(),
      ),
    ).toList();
  }

  static Stream<List<WeeklyChartDataModel>> getWeekly(
      String stockCode, String board) {
    final open = ObjectBoxDatabase.weeklyChartDataBox;
    final stream = open.query(
      WeeklyChartDataModel_.stockCode.equals(stockCode) &
          WeeklyChartDataModel_.board.equals(board),
    )..order(WeeklyChartDataModel_.id, flags: Order.caseSensitive);
    return stream.watch(triggerImmediately: true).map((event) => event.find());
  }
}

class CandleListMonthly {
  static List<KLineEntity> generateList(List<ArrayMonthlyChartData> datas) {
    List<ArrayMonthlyChartData> data = List.filled(
      datas.length,
      ArrayMonthlyChartData(
        closePrice: 0,
        date: int.parse(
            DateFormat("yyyyMMddHHkkmm", 'en_US').format(DateTime.now())),
        openPrice: 0,
        highPrice: 0,
        lowPrice: 0,
        freq: 0,
        value: 0,
        volume: 0,
      ),
    );
    int ins = 0;
    for (var element in datas) {
      if (ins < datas.length) {
        data[ins] = element;
        ins++;
      }
    }
    var sorts = data..sort((a, b) => a.date!.compareTo(b.date!));

    return List.generate(
      sorts.length,
      (index) => KLineEntity.fromCustom(
        close: sorts[index].closePrice!.toInt().toDouble(),
        time: date(sorts[index].date!.toString()),
        open: sorts[index].openPrice!.toInt().toDouble(),
        vol: sorts[index].volume!.toInt().toDouble(),
        high: sorts[index].highPrice!.toInt().toDouble(),
        low: sorts[index].lowPrice!.toInt().toDouble(),
      ),
    ).toList();
  }

  static Stream<List<MonthlyChartDataModel>> getMonthly(
      String stockCode, String board) {
    final open = ObjectBoxDatabase.monthlyChartDataBox;
    final stream = open.query(
      MonthlyChartDataModel_.stockCode.equals(stockCode) &
          MonthlyChartDataModel_.board.equals(board),
    )..order(MonthlyChartDataModel_.id, flags: Order.caseSensitive);
    return stream.watch(triggerImmediately: true).map((event) => event.find());
  }
}
