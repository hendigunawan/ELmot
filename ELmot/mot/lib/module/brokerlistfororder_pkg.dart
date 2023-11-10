import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/brokerlistfororder_model.dart';

updateBrokerListForOder() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  BrokerListForOrderModel listD = BrokerListForOrderModel();
  List<ArrayBrokerRequestData> addData = [];
  List<ArrayDiDalam> addDatadidalam = [];
  //  final object = ObjectBoxDatabase.orderBookBox;

  // login IDL & Login ID
  int lginIDL = getController.encrypt2(buf);
  String Lid = getController.getAsciiString(buf, lginIDL);
  // Array Pertama
  int ARpertama = getController.encrypt4(buf);
  for (int i = 0; i < ARpertama; i++) {
    // brokerIDL & brokerID
    int brkrIDL = getController.encrypt2(buf);
    String brkrID = getController.getAsciiString(buf, brkrIDL);
    // brokernameL & brokerN
    int brkrNML = getController.encrypt2(buf);
    String brkrNM = getController.getAsciiString(buf, brkrNML);
    // baca ArrayDidalam

    addData.add(ArrayBrokerRequestData()
      ..brokerIdL = brkrIDL
      ..brokerID = brkrID
      ..brokerNameL = brkrNML
      ..brokerName = brkrNM);
  }
  int ARdidalam = getController.encrypt4(buf);
  for (int x = 0; x < ARdidalam; x++) {
    // baca ArrayDidalam
    // account IDL & acccountID
    int accntIDL = getController.encrypt2(buf);
    String acntID = getController.getAsciiString(buf, accntIDL);
    //AccountnameL&AccountNAME
    int accntNML = getController.encrypt2(buf);
    String acntNAME = getController.getAsciiString(buf, accntNML);

    addDatadidalam.add(ArrayDiDalam()
      ..accountIdL = accntIDL
      ..accountId = acntID
      ..accountNameL = accntNML
      ..accountName = acntNAME);
  }

  listD = BrokerListForOrderModel(
      loginIdL: lginIDL,
      loginId: Lid,
      array: ARpertama,
      arrayDidalam: ARdidalam);

  print("=====INI datanya");
  print(listD.loginId);
  print(listD.loginId);
  print(listD.array);
}
