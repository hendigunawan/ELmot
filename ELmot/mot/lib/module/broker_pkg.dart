import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/brokerlist_model.dart';

replayBroker() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  List<BrokerList> member = [];

  int arrayL = getController.encrypt4(buf);
  for (int i = 0; i < arrayL; i++) {
    int brokerCodeL = getController.encrypt2(buf);
    String brokerCode = getController.getAsciiString(buf, brokerCodeL);
    int brokerNameL = getController.encrypt2(buf);
    String brokerName = getController.getAsciiString(buf, brokerNameL);
    int nationality = getController.encrypt1(buf);

    member.add(BrokerList()
      ..brokerCodeL = brokerCodeL
      ..brokerCode = brokerCode
      ..brokerNameL = brokerNameL
      ..brokerName = brokerName
      ..nationality = nationality
      ..toJson());
  }
  // print(listM);
}
