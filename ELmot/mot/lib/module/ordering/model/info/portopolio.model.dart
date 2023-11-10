class Portopolio {
  String? loginId;
  String? reference;
  String? accountId;
  int? currentCash;
  int? cashOnTPlus3;
  int? remainTradingLimit;
  int? currentRatio;
  int? marketRatio;
  int? potentialRatio;

  List<ArrayPotopolio>? arrayPorto;

  int? totalMarketValue;
  int? totalPotentialGainLoss;
  int? totalPotentialGainLossPercentage;
  int? t0Date;
  int? t0AR;
  int? t0AP;
  int? t0FundTransferRequest;
  int? t0NetCash;
  int? t1Date;
  int? t1AR;
  int? t1AP;
  int? t1FundTransferRequest;
  int? t1NetCash;
  int? t2Date;
  int? t2AR;
  int? t2AP;
  int? t2FundTransferRequest;
  int? t2NetCash;
  int? t3Date;
  int? t3AR;
  int? t3AP;
  int? t3FundTransferRequest;
  int? t3NetCash;
  int? interest;

  Portopolio({
    this.loginId,
    this.reference,
    this.accountId,
    this.currentCash,
    this.cashOnTPlus3,
    this.remainTradingLimit,
    this.currentRatio,
    this.marketRatio,
    this.potentialRatio,
    this.arrayPorto,
    this.totalMarketValue,
    this.totalPotentialGainLoss,
    this.totalPotentialGainLossPercentage,
    this.t0Date,
    this.t0AR,
    this.t0AP,
    this.t0FundTransferRequest,
    this.t0NetCash,
    this.t1Date,
    this.t1AR,
    this.t1AP,
    this.t1FundTransferRequest,
    this.t1NetCash,
    this.t2Date,
    this.t2AR,
    this.t2AP,
    this.t2FundTransferRequest,
    this.t2NetCash,
    this.t3Date,
    this.t3AR,
    this.t3AP,
    this.t3FundTransferRequest,
    this.t3NetCash,
    this.interest,
  });
}

class ArrayPotopolio {
  String? stockCode;
  int? avgPrice;
  int? lastPrice;
  int? volume;
  int? balance;
  int? openSellVolume;
  int? openBuyVolume;
  int? marketValue;
  int? haircut;
  int? potentialGainLoss;
  int? potentialGainLossPercentage;
  int? marginableStock;
  int? containCAInformation;
  ArrayPotopolio({
    this.stockCode,
    this.avgPrice,
    this.lastPrice,
    this.volume,
    this.balance,
    this.openSellVolume,
    this.openBuyVolume,
    this.marketValue,
    this.haircut,
    this.potentialGainLoss,
    this.potentialGainLossPercentage,
    this.marginableStock,
    this.containCAInformation,
  });
}
