import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202328)
class TradeBookModel {
  @Id()
  int id = 0;
  int? stockCodeL; //jangan di tampilin
  String? stockCode;
  int? boardL;
  String? board;
  int? prevPrice;
  int? array; //nggak wajib diambil
  @Property(type: PropertyType.date)
  int? lastUpdated;
  final arrayList = ToMany<ArrayTradeBook>();
  TradeBookModel(
      {this.stockCodeL,
      this.stockCode,
      this.boardL,
      this.board,
      this.prevPrice,
      this.array,
      this.lastUpdated});
}

@Entity(uid: 1707202329)
class ArrayTradeBook {
  @Id()
  int id = 0;
  int? price;
  int? freq;
  int? volume;
  int? value;
  // edit ini this. nya ketinggalan
  ArrayTradeBook({this.price, this.freq, this.volume, this.value});
}
