import 'package:get/get.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

RxString dataError = ''.obs;
dynamic errorPackage({required int error, bool? type}) {
  if (type == true) {
    Get.find<LoginControl>().isLoading.value = false;
  }
  switch (error) {
    case 0xffff:
      return dataError.value = 'Unknown Error';
    case 0x0001:
      return dataError.value = 'DB Error';
    case 0x0002:
      return dataError.value = "Record Not Found";
    case 0x0003:
      return dataError.value = "Account Expired";
    case 0x0004:
      return dataError.value = "Max Connection Reached";
    case 0x0005:
      return dataError.value = "Password / PIN Not Match";
    case 0x0006:
      return dataError.value = "Password / PIN Expired";
    case 0x0007:
      return dataError.value = "Error On execute Query";
    case 0x0008:
      return dataError.value = "Not enough Volume";
    case 0x0009:
      return dataError.value = "Not enough Trading Limit";
    case 0x000a:
      return dataError.value = "No Shares";
    case 0x000b:
      return dataError.value = "Rejected Order";
    case 0x000c:
      return dataError.value = "Amending Order";
    case 0x000d:
      return dataError.value = "Withdrawing Order";
    case 0x000e:
      return dataError.value = "Withdrawn Order";
    case 0x000f:
      return dataError.value = "Matched Order";
    case 0x0016:
      return dataError.value = "Account Suspended";
    case 0x0017:
      return dataError.value = "Margin Account only can trade marginable Stock";
    case 0x0019:
      return dataError.value = "Invalid Volume";
    case 0x001b:
      return dataError.value = "Potential Cross Order on Market";
    case 0x001c:
      return dataError.value = "Invalid Stock Code";
    case 0x001d:
      return dataError.value = "Syariah Account only can trade Syariah Stock";
    case 0x001e:
      return dataError.value = " Password/PIN already Used Before";

    case 0x001f:
      return dataError.value =
          "You Activated Prevent Same Order, and you already place the same order before.";
    case 0x0021:
      return dataError.value = "Pin / Password Not Fulfill the Min Chars.";
    case 0x0022:
      return dataError.value =
          "Password Not Complex enough / PIN Must Numeric.";
    case 0x0023:
      return dataError.value =
          "System Currently on Daily Consolidation, Please try again later.";
    case 0x0024:
      return dataError.value = "Pin / Password cannot exceed 16 chars.";
    case 0x0025:
      return dataError.value =
          "System Currently on Mock Trading, Please try again later.";
    case 0x0026:
      return dataError.value = "No Connection, Order Rejected.";
    case 0x0027:
      return dataError.value =
          "Package Time Out, Package Request will be discarded.";
    case 0x0028:
      return dataError.value = "Account Inactive";
    case 0x0029:
      return dataError.value = "MAX Retry for PIN / Password.";
    case 0x0030:
      return dataError.value = "Amount input is less than Min Amount.";
    case 0x0031:
      return dataError.value = "Invalid Date.";
    case 0x0032:
      return dataError.value = "Not Enough Cash.";
    default:
      return dataError.value = 'Unhandle Event\nPlease Contect Customer Sevice';
  }
}

class ErrorPopup extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(
      dataError,
      (callback) => popUp(callback),
    );
  }

  void popUp(String data) {
    if (data == '') return;

    if (previousRouteObserver.previousRoute == '/loginview') {
      Get.back();
    }
    Future.delayed(Duration.zero, () => NotifikasiPopup.showFAILED(data));
    dataError.value = '';
  }
}
