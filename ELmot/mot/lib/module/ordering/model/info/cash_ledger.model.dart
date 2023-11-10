class CashLedgerModel {
  String? loginID;
  String? reference;
  String? accountId;
  int? period;

  List<ArrayCashLedger>? array;
  CashLedgerModel({
    this.loginID,
    this.reference,
    this.accountId,
    this.period,
    this.array,
  });
}

class ArrayCashLedger {
  int? transactionDate;
  String? descriptions;
  int? debit;
  int? credit;
  int? balance;

  ArrayCashLedger({
    this.transactionDate,
    this.debit,
    this.credit,
    this.balance,
  });
}
