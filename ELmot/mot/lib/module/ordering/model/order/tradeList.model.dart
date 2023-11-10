class TradeListModel {
  String? loginId;
  String? reference;
  String? accountId;
  List<ArrayTradeList>? array;
}

class ArrayTradeList {
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
