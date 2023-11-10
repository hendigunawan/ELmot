import 'package:objectbox/objectbox.dart';

@Entity(uid: 170720239)
class IntradayChartDataModel {
  @Id()
  int id = 0;
  int? stockCodeL;
  String? stockCode;
  int? boardL;
  String? board;
  int? command;
  int? array;
  final arrayIntradayChartList = ToMany<ArrayIntradayChartData>();
  IntradayChartDataModel(
      {this.stockCodeL,
      this.stockCode,
      this.boardL,
      this.board,
      this.command,
      this.array});
}

@Entity(uid: 1707202310)
class ArrayIntradayChartData {
  @Id()
  int id = 0;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  ArrayIntradayChartData(
      {this.date,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.closePrice,
      this.freq,
      this.value,
      this.volume});
}
