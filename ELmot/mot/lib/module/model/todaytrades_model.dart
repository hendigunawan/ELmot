import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202326)
class TodayTradesDataModel {
  @Id()
  int id = 0;
  String? stockC;
  int? stockCL;
  int? boardL;
  String? board;
  int? command;
  int? prevPrice;
  int? array;
  final arrayTodayList = ToMany<ArrayTodayTRadesData>();
  TodayTradesDataModel(
      {this.stockC,
      this.stockCL,
      this.boardL,
      this.board,
      this.command,
      this.prevPrice,
      this.array});
}

@Entity(uid: 1707202327)
class ArrayTodayTRadesData {
  @Id()
  int id = 0;
  int? tradeId;
  int? time;
  int? lastPrice;
  int? change;
  int? changeRate;
  int? volume;
  String? buyBroker;
  String? buyerType;
  String? sellBroker;
  String? sellerType;

  ArrayTodayTRadesData(
      {this.tradeId,
      this.time,
      this.lastPrice,
      this.change,
      this.changeRate,
      this.volume,
      this.buyBroker,
      this.buyerType,
      this.sellBroker,
      this.sellerType});
}
