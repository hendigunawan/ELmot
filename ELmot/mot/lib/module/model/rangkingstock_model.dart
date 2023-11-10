import 'package:objectbox/objectbox.dart';

@Entity(uid: 0808202320)
class StockData {
  @Id()
  int id = 0;
  int? iBoard;
  int? reqType;
  int? array;
  final arrayData = ToMany<ArrayData>();
  StockData({
    this.iBoard,
    this.reqType,
    this.array,
  });
}

@Entity(uid: 0808202321)
class ArrayData {
  @Id()
  int id = 0;
  int? stockCodeLen;
  String? stockCode;
  int? prevPrice;
  int? lastPrice;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? avgPrice;
  int? change;
  int? changeRate;
  int? tradedFreq;
  int? tradedVolume;
  int? tradedValue;

  ArrayData({
    this.stockCodeLen,
    this.stockCode,
    this.prevPrice,
    this.lastPrice,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.avgPrice,
    this.change,
    this.changeRate,
    this.tradedFreq,
    this.tradedVolume,
    this.tradedValue,
  });
}
