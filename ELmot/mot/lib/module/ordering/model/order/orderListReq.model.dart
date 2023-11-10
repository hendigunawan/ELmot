class OrderList {
  String? loginId;
  String? reference;
  String? accountId;
  List<OrderListData>? array;

  OrderList({
    this.loginId,
    this.reference,
    this.accountId,
    this.array,
  });
}

class OrderListData {
  int? orderStatus;
  String? orderId;
  String? amendId;
  String? idxOrderId;
  int? orderDate;
  int? orderTime;
  int? sentTime;
  String? exchangeCode;
  String? boardMarketCode;
  int? expiry;
  int? command;
  String? stockCode;
  int? price;
  int? oVolume;
  int? rVolume;
  int? tVolume;
  String? inputUser;
  String? counterPartyUid;
  int? sourceId;
  String? sidComplianceId;
  String? clientId;

  OrderListData({
    this.orderStatus,
    this.orderId,
    this.amendId,
    this.idxOrderId,
    this.orderDate,
    this.orderTime,
    this.sentTime,
    this.exchangeCode,
    this.boardMarketCode,
    this.expiry,
    this.command,
    this.stockCode,
    this.price,
    this.oVolume,
    this.rVolume,
    this.tVolume,
    this.inputUser,
    this.counterPartyUid,
    this.sourceId,
    this.sidComplianceId,
    this.clientId,
  });
}
