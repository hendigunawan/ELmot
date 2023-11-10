class LoginReqModel {
  int? cientTL;
  String? clientT;
  int? loginIL;
  String? loginI;
  int? loginPL;
  String? loginP;
  int? iMEIL;
  String? iMEI;
  int? phoneNL;
  String? phoneN;

  LoginReqModel({
    this.cientTL,
    this.clientT,
    this.loginIL,
    this.loginI,
    this.loginPL,
    this.loginP,
    this.iMEIL,
    this.iMEI,
    this.phoneNL,
    this.phoneN,
  });

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    cientTL = json['cientTL'];
    clientT = json['clientT'];
    loginIL = json['loginIL'];
    loginI = json['loginI'];
    loginPL = json['loginPL'];
    loginP = json['loginP'];
    iMEIL = json['iMEIL'];
    iMEI = json['iMEI'];
    phoneNL = json['phoneNL'];
    phoneN = json['phoneN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneN'] = phoneN;
    data['clientT'] = clientT;
    data['loginIL'] = loginIL;
    data['loginIL'] = loginIL;
    data['loginPL'] = loginPL;
    data['loginP'] = loginP;
    data['iMEIL'] = iMEIL;
    data['iMEI'] = iMEI;
    data['phoneNL'] = phoneNL;
    data['phoneN'] = phoneN;
    return data;
  }
}
