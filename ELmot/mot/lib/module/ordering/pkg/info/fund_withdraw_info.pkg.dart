import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/fund_withdraw_info.model.dart';

RxList<FundWithdrawInfoModel> listfundwithdrawInfo =
    <FundWithdrawInfoModel>[].obs;
FundWithdrawInfoModel fundwithdrawInfoPKG(Uint8List buf) {
  var getController = Get.find<EncryptControll>();

  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int Lref = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, Lref);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int t0Date = getController.encrypt4(buf);
  int t0Cash = getController.encrypt8(buf);
  int t1Date = getController.encrypt4(buf);
  int t1Cash = getController.encrypt8(buf);
  int t2Date = getController.encrypt4(buf);
  int t2Cash = getController.encrypt8(buf);
  int t3Date = getController.encrypt4(buf);
  int t3Cash = getController.encrypt8(buf);
  int minimumAmmount = getController.encrypt4(buf);
  int clearingFee = getController.encrypt4(buf);
  int rtgsFee = getController.encrypt4(buf);
  int pindahBukuFee = getController.encrypt4(buf);
  int lbankaccountId = getController.encrypt2(buf);
  String bankAccountId = getController.getAsciiString(buf, lbankaccountId);
  int lbankaccountName = getController.encrypt2(buf);
  String bankAccountName = getController.getAsciiString(buf, lbankaccountName);
  int lbankname = getController.encrypt2(buf);
  String bankName = getController.getAsciiString(buf, lbankname);
  int lbankBranch = getController.encrypt2(buf);
  String bankBranch = getController.getAsciiString(buf, lbankBranch);
  listfundwithdrawInfo.clear();
  FundWithdrawInfoModel data = FundWithdrawInfoModel()
    ..loginID = loginID
    ..reference = Ref
    ..accountId = accountId
    ..t0Date = t0Date
    ..t0Cash = t0Cash
    ..t1Date = t1Date
    ..t1Cash = t1Cash
    ..t2Date = t2Date
    ..t2Cash = t2Cash
    ..t3Date = t3Date
    ..t3Cash = t3Cash
    ..minimumAmmount = minimumAmmount
    ..clearingFee = clearingFee
    ..rtgsFee = rtgsFee
    ..pindahBukuFee = pindahBukuFee
    ..bankAccountId = bankAccountId
    ..bankAccountName = bankAccountName
    ..bankName = bankName
    ..bankBranch = bankBranch;
  listfundwithdrawInfo.add(data);
  return data;
}
