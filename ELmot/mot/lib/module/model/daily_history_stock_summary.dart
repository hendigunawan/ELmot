import 'package:objectbox/objectbox.dart';

@Entity(uid: 170720232)
class DailyHistoryStockSummaryDataModel {
  @Id()
  int? id = 0;
  String? stockC;
  int? stockCL;
  int? boardL;
  String? board;
  int? command;
  int? array;
  final arrayDailyList = ToMany<ArrayDailyHistoryStockSummaryData>();
  DailyHistoryStockSummaryDataModel(
      {this.stockC,
      this.stockCL,
      this.boardL,
      this.board,
      this.command,
      this.array});
}

@Entity(uid: 1707202336)
class ArrayDailyHistoryStockSummaryData {
  @Id()
  int? id = 0;
  int? date;
  int? prevPrice;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? avgPrice;
  int? chg;
  int? chgRate;
  int? freq;
  int? volume;
  int? value;
  // edit ini this. nya ketinggalan
  ArrayDailyHistoryStockSummaryData(
      {this.date,
      this.prevPrice,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.closePrice,
      this.avgPrice,
      this.chg,
      this.chgRate,
      this.freq,
      this.value,
      this.volume});
}
