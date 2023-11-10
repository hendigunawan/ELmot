import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202314)
class MonthlyChartDataModel {
  @Id()
  int id;
  int? stockCodeL;
  String? stockCode;
  int? boardL;
  String? board;
  int? command;
  int? array;
  final arrayMonthlyChartList = ToMany<ArrayMonthlyChartData>();
  MonthlyChartDataModel(
      {this.id = 0,
      this.stockCodeL,
      this.stockCode,
      this.boardL,
      this.board,
      this.command,
      this.array});
}

@Entity(uid: 1707202315)
class ArrayMonthlyChartData {
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

  ArrayMonthlyChartData(
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
