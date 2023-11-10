import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202345)
class RunningTrades {
  @Id()
  int id = 0;
  int? stockCodeL;
  String? stockCode;
  int? lastTradedTime;
  int? tradeId;
  int? lastPrice;
  int? change;
  int? chgRate;
  int? volume;
  int? tradeFlag;
  int? sectorFlag;
  @Property(type: PropertyType.date)
  int? lastUpdated;
  RunningTrades({
    this.stockCodeL,
    this.stockCode,
    this.lastTradedTime,
    this.tradeId,
    this.lastPrice,
    this.change,
    this.chgRate,
    this.volume,
    this.tradeFlag,
    this.sectorFlag,
    this.lastUpdated,
  });
}
