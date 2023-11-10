import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202330)
class WeeklyChartDataModel {
  @Id()
  int id;
  int? stockCodeL;
  String? stockCode;
  int? boardL;
  String? board;
  int? command;
  int? array;
  final arrayWeeklyChartList = ToMany<ArrayWeeklyChartData>();
  WeeklyChartDataModel(
      {this.id = 0,
      this.stockCodeL,
      this.stockCode,
      this.boardL,
      this.board,
      this.command,
      this.array});
}

@Entity(uid: 1707202331)
class ArrayWeeklyChartData {
  @Id()
  int id;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  ArrayWeeklyChartData(
      {this.id = 0,
      this.date,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.closePrice,
      this.freq,
      this.value,
      this.volume});
}

class UpdateArrayWeeklyChartData {
  final String? stockCode;
  final String? board;
  final int? date;
  final int? openPrice;
  final int? highPrice;
  final int? lowPrice;
  final int? closePrice;
  final int? freq;
  final int? volume;
  final int? value;

  UpdateArrayWeeklyChartData({
    this.stockCode,
    this.board,
    this.date,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.closePrice,
    this.freq,
    this.volume,
    this.value,
  });
}
