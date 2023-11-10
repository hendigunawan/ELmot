class LoginOrder {
  int? loginIdLen;
  String? loginId;
  int? referenceLen;
  String? reference;
  int? lot;
  int? loginType;
  int? permissions;
  int? array;
  List<LoginAccont>? account;

  LoginOrder({
    this.loginIdLen,
    this.loginId,
    this.referenceLen,
    this.reference,
    this.lot,
    this.loginType,
    this.permissions,
    this.array,
    this.account,
  });
}

class LoginAccont {
  int? accountIdLen;
  String? accountId;
  int? accountNameLen;
  String? accountName;
  double? onlineFeeBuy;
  double? onlineFeeSell;

  LoginAccont({
    this.accountIdLen,
    this.accountId,
    this.accountNameLen,
    this.accountName,
    this.onlineFeeBuy,
    this.onlineFeeSell,
  });
}
