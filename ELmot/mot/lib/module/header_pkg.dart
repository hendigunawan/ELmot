import 'dart:io';

import 'package:get/get.dart';
import 'package:online_trading/core/compress/snappy.window.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/core/compress/snappy.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/header_model.dart';
import 'package:flutter/foundation.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';

//Create By Hendi 23/jun/2023
PackageHeaders({required Uint8List buf, String? routingKey}) async {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = 0;
//Get package Signature
  int getSignature = getController.encrypt4(buf);
// Pkg Length	Unsigned Int	4
  int getPkgLenght = getController.encrypt4(buf);
// Pkg Id	Unsigned Short	2
  int getPackageID = getController.encrypt2(buf);
//Get Common Flags
  int getCommonFlags = getController.encrypt2(buf);
//Get Error Code
  int getErrorCode = getController.encrypt2(buf);
//Get Reserved
  int getReserved = getController.encrypt4(buf);
  if (Constans.PKG_SIGNATURE == getSignature) {
    if ((getCommonFlags & 0x01) == 0x01) {
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
      getData(data, routingKey!);
      print("ENCRIPT ($getPackageID)");
    } else if ((getCommonFlags & 0x02) == 0x02) {
      Uint8List snappy = Uint8List(0);
      if (Platform.isAndroid) {
        snappy = Uint8List.fromList(
          snappy.toList()
            ..addAll(
              await SnappyCompression.decompress(
                buf.sublist(22),
              ),
            ),
        );
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        var e = Encrypt();
        Uint8List compressedBuff = buf.sublist(22);
        Uint8List buffOriginalLength = buf.sublist(18, 22);
        int originalLength = (e.encrypt4(buffOriginalLength, 0));
        snappy = Uint8List.fromList(
          snappy.toList()
            ..addAll(
              await SnappyCompressionWindows.decompress(
                compressedBuff,
                originalLength,
              ),
            ),
        );
      }
      Uint8List dataBuf =
          Uint8List(Constans.PACKAGE_HEADER_LENGTH + snappy.length);
      ByteData bb = dataBuf.buffer.asByteData();
      for (int i = 0; i < Constans.PACKAGE_HEADER_LENGTH; i++) {
        bb.setUint8(0 + i, buf[i]);
      }
      for (int i = 0; i < snappy.length; i++) {
        bb.setUint8(18 + i, snappy[i]);
      }
      getData(dataBuf, routingKey!);
      print("COMMPRESS ($getPackageID)");
    } else if ((getCommonFlags & 0x03) == 0x03) {
      print("KEDUANYA");
    } else {
      getData(buf, routingKey!);
      return HeaderModel(
        packageSignature: getSignature,
        packageLength: getPkgLenght,
        packageId: getPackageID,
        commonFlags: getCommonFlags,
        errorCode: getErrorCode,
        reserved: getReserved,
      ).toJson();
    }
  }
//-------------------------End Encrypt Header-----------------------------------
}
