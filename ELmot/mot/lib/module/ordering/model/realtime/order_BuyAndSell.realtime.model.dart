class OrderStatusModel {
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
  String? custId;
  String? alt;
  int? nationality;
  int? command;
  String? stockCode;
  int? price;
  int? oVolume;
  int? rVolume;
  int? tVolume;
  String? inputUser;
  String? counterPartyUid;
  int? sourceId;
  int? amendSourceId;
  String? sidComplianceId;
  String? clientId;

  OrderStatusModel({
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
    this.custId,
    this.alt,
    this.nationality,
    this.command,
    this.stockCode,
    this.price,
    this.oVolume,
    this.rVolume,
    this.tVolume,
    this.inputUser,
    this.counterPartyUid,
    this.sourceId,
    this.amendSourceId,
    this.sidComplianceId,
    this.clientId,
  });
}
