class FundWithDrawList {
  String? loginID;
  String? reference;
  String? accountId;
  int? status;
  int? fromDate;
  int? toDate;
  List<ArrayFundWithDrawList>? array;
  FundWithDrawList(
      {this.loginID,
      this.reference,
      this.accountId,
      this.status,
      this.fromDate,
      this.toDate,
      this.array});
}

class ArrayFundWithDrawList {
  int? transferId;
  int? subscribeDate;
  int? subscribeTime;
  int? transferDate;
  int? executedDate;
  int? amount;
  int? fee;
  int? rtgs;
  String? bankId;
  String? bankAccount;
  int? status;
  String? inputBy;
  String? message;
}
