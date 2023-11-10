class RequestTralingOrderModel {
  String? loginId;
  String? reference;
  String? custId;
  List<ArrayRequestTralingOrderModel>? array;

  RequestTralingOrderModel({
    this.loginId,
    this.reference,
    this.custId,
    this.array,
  });
}

class ArrayRequestTralingOrderModel {
  String? orderId;
  int? command;
  String? marketCode;
  String? stockCode;
  int? execPrice;
  int? volume;
  int? autoPriceStep;
  int? dropPrice;
  int? trailingPriceType;
  int? trailingStep;
  int? stopPrice;
  int? trailingPrice;
  int? executedPrice;
  int? orderStatus;
  int? orderDate;
  int? orderTime;
  int? sentDate;
  int? sentTime;
  int? startDate;
  int? dueDate;
  int? sourceId;
  int? withdrawSrcId;
  String? inputUser;
  String? withdrawBy;
  String? description;
  String? clientIpAddress;
  String? resultNote;
  ArrayRequestTralingOrderModel({
    this.orderId,
    this.command,
    this.marketCode,
    this.stockCode,
    this.execPrice,
    this.volume,
    this.autoPriceStep,
    this.dropPrice,
    this.trailingPriceType,
    this.trailingStep,
    this.stopPrice,
    this.trailingPrice,
    this.executedPrice,
    this.orderStatus,
    this.orderDate,
    this.orderTime,
    this.sentDate,
    this.sentTime,
    this.startDate,
    this.dueDate,
    this.sourceId,
    this.withdrawSrcId,
    this.inputUser,
    this.withdrawBy,
    this.description,
    this.clientIpAddress,
    this.resultNote,
  });
}
