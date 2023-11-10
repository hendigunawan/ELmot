import 'package:objectbox/objectbox.dart';

@Entity(uid: 0108202301)
class Quotes {
  @Id()
  int id = 0;
  String? stockCode;
  String? board;
  int? lastTradedTime;
  int? prevPrice;
  int? prevChg;
  int? prevChgRate;
  int? lastPrice;
  int? change;
  int? chgRate;
  int? openPrice;
  int? hiPrice;
  int? loPrice;
  int? avgPrice;
  int? freq;
  int? volume;
  int? value;
  int? fgNetValue;
  int? marketCaps;
  int? bestBidPrice;
  int? bestBidVol;
  int? bestOfferPrice;
  int? bestOfferVol;
  int? IEPrice;
  int? IEVolume;
  Quotes(
      {this.stockCode,
      this.board,
      this.lastTradedTime,
      this.prevPrice,
      this.prevChg,
      this.prevChgRate,
      this.lastPrice,
      this.change,
      this.chgRate,
      this.openPrice,
      this.hiPrice,
      this.loPrice,
      this.avgPrice,
      this.freq,
      this.volume,
      this.value,
      this.fgNetValue,
      this.marketCaps,
      this.bestBidPrice,
      this.bestBidVol,
      this.bestOfferPrice,
      this.bestOfferVol,
      this.IEPrice,
      this.IEVolume});
}
