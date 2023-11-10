class HistoricalTradeListModel {
  String? loginId;
  String? reference;
  String? accountId;
  List<ArrayHistoricalTradeListModel>? array;
}

class ArrayHistoricalTradeListModel {
  String? orderId;
  String? idxOrderId;
  String? idxTradeId;
  int? tradeDate;
  int? tradeTime;
  String? exchangeCode;
  String? board;
  int? expiry;
  int? command;
  String? stockCode;
  int? price;
  int? volume;
  String? counterPartyUid;
  int? sourceId;
}
