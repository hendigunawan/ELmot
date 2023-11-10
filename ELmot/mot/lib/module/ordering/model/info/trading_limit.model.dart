class TradingLimit {
  String? loginId;

  String? reference;

  String? accountId;

  String? accountName;
  int? currentCash;
  int? rdnBalance;
  int? cashonT3;
  int? currentRatio;
  int? tradingLimit;
  int? remainTradingLimit;

  TradingLimit({
    this.loginId,
    this.reference,
    this.accountId,
    this.accountName,
    this.currentCash,
    this.rdnBalance,
    this.cashonT3,
    this.currentRatio,
    this.tradingLimit,
    this.remainTradingLimit,
  });
}
