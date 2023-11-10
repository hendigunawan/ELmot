import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';

ParameterPkg() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int dataFalg = getController.encrypt4(buf);

  switch (dataFalg) {
    case 1:
      int lotSize = getController.encrypt4(buf);
      lotSize;
      break;
    case 2:
      int arrayL = getController.encrypt4(buf);
      List<ArrayFaksi> data = [];
      for (int i = 0; i < arrayL; i++) {
        int price = getController.encrypt4(buf);
        int fraksi = getController.encrypt2(buf);

        data.add(
          ArrayFaksi(price: price, fraction: fraksi),
        );
      }
      Get.find<BodyController>().fraksi.value =
          DataFraksi(flag: dataFalg, array: data);
      Get.find<BodyController>().fraksi.refresh();
      break;
    case 3:
  }
}
