import 'package:online_trading/core/compress/snappy.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/header_model.dart';
import 'package:flutter/foundation.dart';
import 'package:online_trading/module/ordering/irigasi/proses/data_proses.order.dart';
import 'package:online_trading/module/ordering/irigasi/proses/hendle_error.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/view/checkoutview/mainchechout_view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/new_OrderSell.widget.dart';

//Create By Hendi 23/jun/2023
PackageHeadersOrder({required Uint8List buf, String? routingKey}) async {
//Get package Signature
  ValueNotifier<int> getSignature = ValueNotifier(Encrypt().encrypt4(buf, 0));
// Pkg Length	Unsigned Int	4
  ValueNotifier<int> getPkgLenght = ValueNotifier(Encrypt().encrypt4(buf, 4));
// Pkg Id	Unsigned Short	2
  ValueNotifier<int> getPackageID = ValueNotifier(Encrypt().encrypt2(buf, 8));
//Get Common Flags

  ValueNotifier<int> getCommonFlags =
      ValueNotifier(Encrypt().encrypt2(buf, 10));
//Get Error Code
  ValueNotifier<int> getErrorCode = ValueNotifier(Encrypt().encrypt2(buf, 12));
//Get Reserved
  ValueNotifier<int> getReserved = ValueNotifier(Encrypt().encrypt4(buf, 14));
  onLoadingOrder(getPackageID.value);
  if (getErrorCode.value != 0) {
    return errorPackage(
        error: getErrorCode.value, type: getPackageID.value == 1 ? true : null);
  }
  if (Constans.PKG_SIGNATURE == getSignature.value) {
    if ((getCommonFlags.value & 0x01) == 0x01) {
      int pos = Constans.PACKAGE_HEADER_LENGTH + 4;
      Uint8List encryptedData = buf.sublist(pos);
      Uint8List originalData = decrypt(encryptedData);
      Uint8List data =
          Uint8List(Constans.PACKAGE_HEADER_LENGTH + originalData.length);
      ByteData datas = data.buffer.asByteData();
      for (int i = 0; i < Constans.PACKAGE_HEADER_LENGTH; i++) {
        datas.setUint8(i, buf[i]);
      }
      for (int i = 0; i < originalData.length; i++) {
        datas.setUint8(18 + i, originalData[i]);
      }
      DataProses.order(
        data,
        routingKey: routingKey!,
        idPackage: getPackageID.value,
      );
      print("ENCRIPT ($getPackageID)");
    } else if ((getCommonFlags.value & 0x02) == 0x02) {
      Uint8List snappy = await SnappyCompression.decompress(buf.sublist(22));
      Uint8List dataBuf =
          Uint8List(Constans.PACKAGE_HEADER_LENGTH + snappy.length);
      ByteData bb = dataBuf.buffer.asByteData();
      for (int i = 0; i < Constans.PACKAGE_HEADER_LENGTH; i++) {
        bb.setUint8(0 + i, buf[i]);
      }
      for (int i = 0; i < snappy.length; i++) {
        bb.setUint8(18 + i, snappy[i]);
      }
      DataProses.order(
        dataBuf,
        routingKey: routingKey!,
        idPackage: getPackageID.value,
      );
      print("COMMPRESS ($getPackageID)");
    } else if ((getCommonFlags.value & 0x03) == 0x03) {
      print("KEDUANYA");
    } else {
      DataProses.order(
        buf,
        routingKey: routingKey!,
        idPackage: getPackageID.value,
      );
      return HeaderModel(
        packageSignature: getSignature.value,
        packageLength: getPkgLenght.value,
        packageId: getPackageID.value,
        commonFlags: getCommonFlags.value,
        errorCode: getErrorCode.value,
        reserved: getReserved.value,
      ).toJson();
    }
  }
//-------------------------End Encrypt Header-----------------------------------
}

void onLoadingOrder(int type) {
  if (type == Constans.PACKAGE_ID_NEW_ORDER_REPLY_ORDER_REALTIME ||
      type == Constans.PACKAGE_ID_REQUEST_ORDER) {
    onTapConfirm.value = true;
    onChackOut.value = '';
  } else if (type == Constans.PACKAGE_ID_REQUEST_AMEND ||
      type == Constans.PACKAGE_ID_AMEND_REPLY_ORDER_REALTIME) {
  } else if (type == Constans.PACKAGE_ID_REQUEST_WITHDRAW) {
  } else if (type == Constans.PACKAGE_ID_REQUEST_NEW_BREAK_OERDER) {
  } else if (type == Constans.PACKAGE_ID_REQUEST_NEW_GTC_ORDER) {
  } else if (type == Constans.PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER) {}
}
