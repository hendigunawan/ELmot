import 'package:get/get.dart';
import 'package:online_trading/core/connection_cek.dart';
import 'package:online_trading/module/ordering/model/info/login_order.model.dart';

class LoginOrderController extends GetxController {
  Rx<LoginOrder>? order = LoginOrder().obs;

  @override
  void onInit() {
    super.onInit();
    ever(
      order!,
      (callback) {
        if (callback.account == null) {
          return;
        } else {
          Get.find<CekConnect>().done();
          Get.offNamed('/homeview');
        }
        // if (callback.account != null ||
        //     callback.loginId != null ||
        //     callback.account!.isNotEmpty ||
        //     callback.loginId != '') {
        //   FlutterNativeSplash.remove();
        // }
      },
    );
  }
}
