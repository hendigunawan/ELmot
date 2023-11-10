import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/realtime/login_realtime.model.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

LoginRealtimeModel loginOrderRealtime(Uint8List buf) {
  LoginRealtimeModel data = LoginRealtimeModel();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int clientApi = getController.encrypt2(buf);
  data.clientIP = getController.getAsciiString(buf, clientApi);
  int loginId = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginId);
  int reference = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, reference);
  data.loginType = getController.encrypt1(buf);
  data.permissions = getController.encrypt4(buf);
  Get.put(SudahAdaYangLogin()).validate.value = data;
  return data;
}

class SudahAdaYangLogin extends GetxController {
  Rx<LoginRealtimeModel> validate = LoginRealtimeModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(validate, (callback) => logout(callback));
  }

  void logout(LoginRealtimeModel data) {
    if (data.loginId == null) return;
    Get.put(LogoutController()).onLogoutSuccess();
    Get.offAllNamed('/loginview');
    NotifikasiPopup.showINFO(text: 'There Is Login With Other Device');
  }
}
