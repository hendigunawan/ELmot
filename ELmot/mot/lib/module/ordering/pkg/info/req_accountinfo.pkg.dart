import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/account_info.model.dart';

RxList<AccountInfo> listAccountInfo = <AccountInfo>[].obs;
AccountInfo accountInfo(Uint8List buf) {
  listAccountInfo.clear();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);

  String loginId = getController.getAsciiString(buf, lLogin);

  int Lref = getController.encrypt2(buf);

  String Ref = getController.getAsciiString(buf, Lref);

  int LAccount = getController.encrypt2(buf);

  String AccountId = getController.getAsciiString(buf, LAccount);

  int OnlineFBUY = getController.getDouble(buf);
  int OnlineFSELL = getController.getDouble(buf);

  int LKSEI = getController.encrypt2(buf);

  String KSEI = getController.getAsciiString(buf, LKSEI);

  int LSID = getController.encrypt2(buf);

  String SID = getController.getAsciiString(buf, LSID);

  int LASTATUS = getController.encrypt2(buf);

  String ASTATUS = getController.getAsciiString(buf, LASTATUS);

  int LIDTYPE = getController.encrypt2(buf);

  String IDTYPE = getController.getAsciiString(buf, LIDTYPE);

  int LIDNO = getController.encrypt2(
    buf,
  );

  String IDNO = getController.getAsciiString(buf, LIDNO);

  int IDEXPRITY = getController.encrypt4(
    buf,
  );

  int LCUSTYPE = getController.encrypt2(
    buf,
  );

  String CUSTYPE = getController.getAsciiString(buf, LCUSTYPE);

  int LNATION = getController.encrypt2(
    buf,
  );

  String NATION = getController.getAsciiString(buf, LNATION);

  int LMOTHER = getController.encrypt2(
    buf,
  );

  String MOTHER = getController.getAsciiString(buf, LMOTHER);

  int LJOB = getController.encrypt2(
    buf,
  );

  String JOB = getController.getAsciiString(buf, LJOB);

  int LCOMPANY = getController.encrypt2(
    buf,
  );

  String COMPANY = getController.getAsciiString(buf, LCOMPANY);

  int OPENINGACCOUNTDATE = getController.encrypt4(
    buf,
  );

  int MANAGBRANClen = getController.encrypt2(buf);

  String MANAGINGBRANCH = getController.getAsciiString(buf, MANAGBRANClen);

  int LBANKCODE = getController.encrypt2(
    buf,
  );

  String BANKCODE = getController.getAsciiString(buf, LBANKCODE);

  int LBANKACCOUNTNO = getController.encrypt2(
    buf,
  );

  String BANKACCOUNTNO = getController.getAsciiString(buf, LBANKACCOUNTNO);

  int LBANKACCOUNTNAME = getController.encrypt2(buf);

  String BANKACCOUNTNAME = getController.getAsciiString(buf, LBANKACCOUNTNAME);

  int LRDNBANKC = getController.encrypt2(buf);

  String RDNBANKC = getController.getAsciiString(buf, LRDNBANKC);

  int LRDNBANKACC = getController.encrypt2(buf);

  String RDNBANKACC = getController.getAsciiString(buf, LRDNBANKACC);

  int LRDNBANKACCNAME = getController.encrypt2(buf);

  String RDNBANKACCNAME = getController.getAsciiString(buf, LRDNBANKACCNAME);

  int RDNBANKACCNAMEOPENINGDATE = getController.encrypt4(buf);

  int LEMAIL = getController.encrypt2(buf);

  String EMAIl = getController.getAsciiString(buf, LEMAIL);

  int LPHONE = getController.encrypt2(buf);

  String PHONE = getController.getAsciiString(buf, LPHONE);

  int LHANDPHONE = getController.encrypt2(buf);

  String HANDPHONE = getController.getAsciiString(buf, LHANDPHONE);

  int LOFFICEPHONE = getController.encrypt2(buf);

  String OFFICEPHONE = getController.getAsciiString(buf, LOFFICEPHONE);

  int LHOMEADD = getController.encrypt2(buf);

  String HOMEADD = getController.getAsciiString(buf, LHOMEADD);

  int LOFFADDRESS = getController.encrypt2(buf);

  String OFFADDRESS = getController.getAsciiString(buf, LOFFADDRESS);

  AccountInfo list = AccountInfo()
    ..loginId = loginId
    ..reference = Ref
    ..accountId = AccountId
    ..onlineFeeBuy = OnlineFBUY
    ..onlineFeeSell = OnlineFSELL
    ..kseiAccountNoLen = LKSEI
    ..kseiAccountNo = KSEI
    ..sid = SID
    ..accountStatus = ASTATUS
    ..idType = IDTYPE
    ..idNo = IDNO
    ..idExpiry = IDEXPRITY
    ..customerType = CUSTYPE
    ..nationality = NATION
    ..mothersName = MOTHER
    ..job = JOB
    ..companyName = COMPANY
    ..openingAccountDate = OPENINGACCOUNTDATE
    ..managingBranch = MANAGINGBRANCH
    ..bankCode = BANKCODE
    ..bankAccountName = BANKACCOUNTNAME
    ..rdnBankCode = RDNBANKC
    ..rdnBankAccountNo = RDNBANKACC
    ..rdnBankAccountName = RDNBANKACCNAME
    ..rdnBankAccountOpenDate = RDNBANKACCNAMEOPENINGDATE
    ..email = EMAIl
    ..phone = PHONE
    ..handPhone = HANDPHONE
    ..officePhone = OFFICEPHONE
    ..homeAddress = HOMEADD
    ..officeAddress = OFFADDRESS
    ..bankAccountNo = BANKACCOUNTNO;
  listAccountInfo.add(list);
  listAccountInfo.refresh();
  print(listAccountInfo);
  return list;
}
