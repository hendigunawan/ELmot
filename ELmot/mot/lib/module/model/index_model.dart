import 'package:objectbox/objectbox.dart';

// Ini diedit diubah menjadi object box
@Entity(uid: 170720236)
class IndexModelS {
  @Id()
  int? id = 0;
  int? indexCodeL;
  String? indexCode;
  int? lastUpdateT;
  int? currentI; //I = Index
  int? prevI;
  int? openI;
  int? highI;
  int? lowI;
  int? change;
  int? changeR;
  int? freq;
  int? volume;
  int? value;
  int? up;
  int? down;
  int? unChange;
  int? noTransaksi;
  int? baseValue;
  int? marketValue;
  int? fgBuyFreq;
  int? fgSellFreq;
  int? fgBuyVol;
  int? fgSellVol;
  int? fgBuyVal;
  int? fgSellVal;
  IndexModelS({
    this.indexCodeL,
    this.indexCode,
    this.lastUpdateT,
    this.currentI, //I = Index
    this.prevI,
    this.openI,
    this.highI,
    this.lowI,
    this.change,
    this.changeR,
    this.freq,
    this.volume,
    this.value,
    this.up,
    this.down,
    this.unChange,
    this.noTransaksi,
    this.baseValue,
    this.marketValue,
    this.fgBuyFreq,
    this.fgSellFreq,
    this.fgBuyVol,
    this.fgSellVol,
    this.fgBuyVal,
    this.fgSellVal,
  });
}
