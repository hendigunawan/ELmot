import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/accountWidget/change_pinataupassword.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

changepasswordPKG(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int loginID = getController.encrypt2(buf);
  getController.getAsciiString(buf, loginID);
  int type = getController.encrypt1(buf);
  if (type == 0) {
    var controller = Get.find<ChangePinPasswordController>();
    controller.isDone.toggle();
    Get.put(LoginControl()).store.setPassWord(controller.updatePass.value);

    NotifikasiPopup.showSUCCESS('Success\nChange Password');
  } else {
    Get.find<ChangePinPasswordController>().isDone.toggle();
    NotifikasiPopup.showSUCCESS('Success\nChange Pin');
  }
}
