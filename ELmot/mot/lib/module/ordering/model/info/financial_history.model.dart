class FinancialHistoryModel {
  String? loginID;
  String? reference;
  String? accountId;
  int? period;
  int? rdnBalance;
  List<ArrayFinancialhistoryModel>? array;
  FinancialHistoryModel({
    this.loginID,
    this.reference,
    this.accountId,
    this.period,
    this.rdnBalance,
    this.array,
  });
}

class ArrayFinancialhistoryModel {
  int? transactionDate;
  String? descriptions;
  int? debit;
  int? credit;
  int? balance;

  ArrayFinancialhistoryModel({
    this.transactionDate,
    this.debit,
    this.credit,
    this.balance,
  });
}
