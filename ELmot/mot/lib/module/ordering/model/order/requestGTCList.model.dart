class RequestGTCList {
  String? loginId;
  String? reference;
  String? accountId;
  List<RequestGTCArray>? array;

  RequestGTCList({
    this.loginId,
    this.reference,
    this.accountId,
    this.array,
  });
}

class RequestGTCArray {
  String? gtcId;
  int? subscribeDate;
  int? subscribeTime;
  int? effectiveDate;
  int? dueDate;
  int? sessionId;
  int? gtcFlags;
  String? exchangeCode;
  String? marketCode;
  int? expiry;
  int? command;
  String? stockCode;
  int? price;
  int? oVolume;
  int? rVolume;
  int? tVolume;
  int? autoPriceStep;
  int? subscribeStatus;
  int? sourceId;
  int? cancelSourceId;
  String? inputUser;
  String? cancelUser;
  String? complianceId;
  RequestGTCArray({
    this.gtcId,
    this.subscribeDate,
    this.subscribeTime,
    this.effectiveDate,
    this.dueDate,
    this.sessionId,
    this.gtcFlags,
    this.exchangeCode,
    this.marketCode,
    this.expiry,
    this.command,
    this.stockCode,
    this.price,
    this.oVolume,
    this.rVolume,
    this.tVolume,
    this.autoPriceStep,
    this.subscribeStatus,
    this.sourceId,
    this.cancelSourceId,
    this.inputUser,
    this.cancelUser,
    this.complianceId,
  });
}
