class StockBalance {
  String? loginId;

  String? reference;

  String? accountId;

  List<StockBalanceARRAY>? stocks;

  StockBalance({
    this.loginId,
    this.reference,
    this.accountId,
    this.stocks,
  });
}

class StockBalanceARRAY {
  int? stockCodeLen;
  String? stockCode;
  int? avgPrice;
  int? lastPrice;
  int? volume;
  int? balance;
  int? potentialGainLoss;
  int? potentialGainLossPercentage;

  StockBalanceARRAY({
    this.stockCode,
    this.avgPrice,
    this.lastPrice,
    this.volume,
    this.balance,
    this.potentialGainLoss,
    this.potentialGainLossPercentage,
  });
}
