import 'package:online_trading/helper/constants.dart';

class HeaderModel {
  int? packageSignature;
  int? packageLength;
  int? packageId;
  int? commonFlags;
  int? errorCode;
  int? reserved;
  HeaderModel({
    this.packageSignature,
    this.packageLength,
    this.packageId,
    this.commonFlags,
    this.errorCode,
    this.reserved,
  });

  HeaderModel.fromJson(Map<String, dynamic> json) {
    packageSignature = json['packageSignature'];
    packageLength = json['packageLength'];
    packageId = json['packageId'];
    commonFlags = json['commonFlags'];
    errorCode = json['errorCode'];
    reserved = json['reserved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageSignature'] = packageSignature;
    data['packageLength'] = packageLength;
    data['packageId'] = packageId;
    data['commonFlags'] = commonFlags;
    data['errorCode'] = errorCode;
    data['reserved'] = reserved;
    print("PACKAGE SIGNATURE CONSTANS: ${Constans.PKG_SIGNATURE}");
    print("DATA HEADER: $data");
    return data;
  }
}
