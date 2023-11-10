class MonthlyBalanceRemainYear {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  List<ArrayMonthlyBalanceRemainYear>? array;
  MonthlyBalanceRemainYear({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.array,
  });
}

class ArrayMonthlyBalanceRemainYear {
  int? remainyearData;
  ArrayMonthlyBalanceRemainYear({this.remainyearData});
}

class MonthlyBalanceByYear {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  int? yearDate;
  List<ArrayMonthlyBalanceByYear>? array;
  int? totalMarketValue;
  int? totalPotentialGainLoss;
  int? totalPotentialGainLossPercentage;
  int? totalCash;
  int? totalAsset;
}

class ArrayMonthlyBalanceByYear {
  String? stockcode;
  int? avgPrice;
  int? closePrice;
  int? balanceQty;
  int? marketValue;
  int? potentialGainLoss;
  int? potentialGainLossPercentage;
}
