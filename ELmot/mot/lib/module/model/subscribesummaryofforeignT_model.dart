import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202324)
class SubscribeSummaryForeignTModel {
  @Id()
  int? id = 0;
  int? stockCodeL;
  String? stockCode;
  int? boardL;
  String? board;
  int? tanggal;
  int? prevPrice;
  int? lastPrice;
  int? fgAvgPriceBuy;
  int? fgAvgPriceSell;
  int? fgBuyVolume;
  int? fgSellVolume;
  int? fgNettVolume;
  int? fgBuyValue;
  int? fgSellValue;
  int? fgNettValue;
  int? array;
  final arrayDataList = ToMany<ArraySubscribeSummaryForeignT>();
  SubscribeSummaryForeignTModel(
      {this.stockCodeL,
      this.stockCode,
      this.boardL,
      this.board,
      this.tanggal,
      this.prevPrice,
      this.lastPrice,
      this.fgAvgPriceBuy,
      this.fgAvgPriceSell,
      this.fgBuyVolume,
      this.fgSellVolume,
      this.fgNettVolume,
      this.fgBuyValue,
      this.fgSellValue,
      this.fgNettValue,
      this.array});
}

@Entity(uid: 1707202325)
class ArraySubscribeSummaryForeignT {
  @Id()
  int? id = 0;
  int? tanggal;
  int? prevPrice;
  int? closedPrice;
  int? fgAvgPriceBuy;
  int? fgAvgPriceSell;
  int? fgBuyVolume;
  int? fgSellVolume;
  int? fgNettVolume;
  int? fgBuyValue;
  int? fgSellValue;
  int? fgNettValue;
  ArraySubscribeSummaryForeignT(
      {this.tanggal,
      this.prevPrice,
      this.closedPrice,
      this.fgAvgPriceBuy,
      this.fgAvgPriceSell,
      this.fgBuyVolume,
      this.fgSellVolume,
      this.fgNettVolume,
      this.fgBuyValue,
      this.fgSellValue,
      this.fgNettValue});
}
