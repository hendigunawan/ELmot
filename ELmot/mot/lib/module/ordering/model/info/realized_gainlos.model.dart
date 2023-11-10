class RealizedGainLost {
  String? loginId;
  String? reference;
  String? accountId;
  int? period;
  List<ArrayRealizedGainLost>? array;

  RealizedGainLost({
    this.loginId,
    this.reference,
    this.accountId,
    this.period,
    this.array,
  });
}

class ArrayRealizedGainLost {
  int? transactionDate;
  int? command;
  String? stockCode;
  int? avgPrice;
  int? price;
  int? volume;
  int? gainLossSign;
  int? totalGainLossSign;

  ArrayRealizedGainLost({
    this.transactionDate,
    this.command,
    this.stockCode,
    this.avgPrice,
    this.price,
    this.volume,
    this.gainLossSign,
    this.totalGainLossSign,
  });
}
