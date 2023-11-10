class PortopolioReturn {
  String? loginId;

  String? reference;

  String? accountId;
  int? requestType;
  int? startDate;
  int? endDate;
  List<ArrayPotopolioReturn>? arrayPortoReturn;
  int? totalAssetValue;
  int? totalDeposit;
  int? totalWithdraw;
  int? totalUnrealizedGainLoss;
  int? totalYieldPercentage;
  PortopolioReturn({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.startDate,
    this.endDate,
    this.arrayPortoReturn,
    this.totalAssetValue,
    this.totalDeposit,
    this.totalWithdraw,
    this.totalUnrealizedGainLoss,
    this.totalYieldPercentage,
  });
}

class ArrayPotopolioReturn {
  int? date;
  int? assetValue;
  int? deposit;
  int? withdraw;
  int? unrealizedGainLoss;
  int? yieldPercentage;

  ArrayPotopolioReturn({
    this.date,
    this.assetValue,
    this.deposit,
    this.withdraw,
    this.unrealizedGainLoss,
    this.yieldPercentage,
  });
}
