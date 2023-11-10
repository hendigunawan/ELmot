import 'package:encrypt/encrypt.dart';
import 'dart:typed_data';
import 'dart:math';

import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';

Uint8List createEncryptedMessage(int packageId, Uint8List data, int xlength) {
  // Lakukan enkripsi terhadap data yang mau dikirim
  // Uint8List encryptedData = encrypt(data);

  // Simpan data package header + panjang data + encrypted data ke dalam Uint8List
  Uint8List request = Uint8List(Constans.PACKAGE_HEADER_LENGTH + xlength + 4);
  int offset = 0;

  // Package Header
  Uint8List packageHeader =
      createPackageHeader(Constans.PACKAGE_HEADER_LENGTH + xlength, packageId);
  request.setRange(
      offset, offset + Constans.PACKAGE_HEADER_LENGTH, packageHeader);
  offset += Constans.PACKAGE_HEADER_LENGTH;

  // Pkg Length
  // Uint8List pkgLength = Uint8List(4)
  //   ..buffer.asByteData().setUint32(0, xlength, Endian.big);
  // request.setRange(offset, offset + 4, pkgLength);
  // offset += 4;

  // Encrypted Data
  request.setRange(offset, offset + xlength, data);
  // print(request);
  return request;
}

Uint8List encrypt(Uint8List input) {
  final key = Key.fromUtf8(Constans.ENCRYPTIONKEY);
  final ivBytes = IV.fromUtf8(Constans.IV);
  final encrypter = Encrypter(
    AES(key, mode: AESMode.sic, padding: Constans.PADDING),
  );
  final encrypted = encrypter.encryptBytes(input, iv: ivBytes);
  return encrypted.bytes;
}

Uint8List decrypt(Uint8List cipherText) {
  final key = Key.fromUtf8(Constans.ENCRYPTIONKEY);
  final ivBytes = IV.fromUtf8(Constans.IV);
  final encrypter =
      Encrypter(AES(key, mode: AESMode.cbc, padding: Constans.PADDING));
  final decrypted = encrypter.decryptBytes(Encrypted(cipherText), iv: ivBytes);
  return Uint8List.fromList(decrypted);
}

String generateRandomCode(int length) {
  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  String code = '';

  for (int i = 0; i < length; i++) {
    code += chars[random.nextInt(chars.length)];
  }

  return code;
}

List<int> encodeLength(int length) {
  List<int> encoded = [];
  encoded.add((length >> 8) & 0xFF);
  encoded.add(length & 0xFF);
  return encoded;
}

List<int> encodeString(String string) {
  List<int> encoded = [];
  for (int i = 0; i < string.length; i++) {
    encoded.add(string.codeUnitAt(i));
  }
  return encoded;
}

List<int> set32(dynamic data) {
  Uint8List dat = Uint8List(4);

  dat.buffer.asByteData().setUint32(
        0,
        int.parse(
          data.toString(),
        ),
      );

  return dat;
}

List<int> set64(dynamic data) {
  Uint8List dat = Uint8List(8);

  dat.buffer.asByteData().setUint64(
        0,
        int.parse(
          data.toString(),
        ),
      );

  return dat;
}

List<int> set16(dynamic data) {
  Uint8List dat = Uint8List(4);

  dat.buffer.asByteData().setUint16(
        0,
        int.parse(
          data.toString(),
        ),
      );

  return dat;
}

Uint8List makeArrayByte(List<ArrayStockCode> array) {
  Uint8List encodeList = Uint8List(0);
  int iterationCount = 0;
  for (int i = 0; i < array.length; i++) {
    if (iterationCount % 4 <= 3) {
      int readspos = array[i].stockCode!.length;
      if (array[i].stockCode!.length >= 4) {
        encodeList = Uint8List.fromList(
          encodeList.toList()
            ..addAll(
              encodeLength(readspos),
            ),
        );
        encodeList = Uint8List.fromList(
          encodeList.toList()
            ..addAll(
              encodeString(
                array[i].stockCode.toString(),
              ),
            ),
        );
      }
      if (array[i].board == 'RG' ||
          array[i].board == 'TN' ||
          array[i].board == 'NG') {
        encodeList = Uint8List.fromList(
          encodeList.toList()
            ..addAll(
              encodeString(
                array[i].board.toString(),
              ),
            ),
        );
      }
    }
    iterationCount++;
  }

  return encodeList;
}

Uint8List createHeartBeat() {
  final openBox = ObjectBoxDatabase.infoMobile;

  Uint8List header = Uint8List(0);
  Uint8List body = Uint8List(0);

  body = Uint8List.fromList(
    body.toList()
      ..addAll(
        encodeLength(openBox.get(1)!.clientTag!.length),
      ),
  );
  body = Uint8List.fromList(
    body.toList()
      ..addAll(
        encodeString(openBox.get(1)!.clientTag!),
      ),
  );

  header = Uint8List.fromList(
    header.toList()
      ..addAll(
        createPackageHeader(
                Constans.PACKAGE_HEADER_LENGTH + body.length, 0xffff) +
            body,
      ),
  );

  return header;
}

Uint8List createPackageHeader(int length, int packageId) {
  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  Uint8List headers = Uint8List(packageHeaderLength);
  ByteData byteData = headers.buffer.asByteData();

  byteData.setUint32(0, Constans.PKG_SIGNATURE); // Pkg Signature
  byteData.setUint32(4, length); // Pkg Length
  byteData.setUint16(8, packageId); // Pkg Id
  byteData.setUint16(10, 0); // Common Flags
  byteData.setUint16(12, 0); // Error Code
  byteData.setUint32(14, 0); // Reserved

  return headers;
}

Uint8List createLoginRequest({
  required String clientTag,
  required String loginId,
  required String loginPassword,
  String imei = "",
  String phoneNo = "",
}) {
  int xlength = clientTag.length +
      loginId.length +
      loginPassword.length +
      imei.length +
      phoneNo.length +
      10;
  // pastikan bahwa panjang data merupakan kelipatan 16
  if ((xlength % 16) != 0) {
    xlength = xlength + (16 - (xlength % 16));
  }

  // simpan data yang mau dikirim kedalam list of byte
  Uint8List data = Uint8List(xlength);
  ByteData bbData = data.buffer.asByteData();

  bbData.setUint16(
      0, clientTag.length, Endian.big); // Client Tag Len	Unsigned Short	2
  for (int i = 0; i < clientTag.length; i++) {
    bbData.setUint8(
        2 + i, clientTag.codeUnitAt(i)); // Client Tag	Char	64	Max 63 chars
  }

  int offset = 2 + clientTag.length;

  bbData.setUint16(
      offset, loginId.length, Endian.big); // Login Id Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < loginId.length; i++) {
    bbData.setUint8(
        offset + i, loginId.codeUnitAt(i)); // Login Id	char	30	Max 30 chars
  }

  offset += loginId.length;

  bbData.setUint16(offset, loginPassword.length,
      Endian.big); // Login Password Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < loginPassword.length; i++) {
    bbData.setUint8(
        offset + i,
        loginPassword
            .codeUnitAt(i)); // Login Password	Unsigned Short	15	Max 15 chars
  }

  offset += loginPassword.length;

  bbData.setUint16(
      offset, imei.length, Endian.big); // IMEI Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < imei.length; i++) {
    bbData.setUint8(offset + i, imei.codeUnitAt(i)); // IMEI	char	64
  }

  offset += imei.length;

  bbData.setUint16(
      offset, phoneNo.length, Endian.big); // PhoneNo Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < phoneNo.length; i++) {
    bbData.setUint8(offset + i, phoneNo.codeUnitAt(i)); // Phone No	char	64
  }

  return createEncryptedMessage(Constans.PACKAGE_ID_LOGIN, data, xlength);
}

// STOCKLIST REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createStockListRequest(String clientTag, int packageId) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// BROKERLIST REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createBrokerListRequest(String clientTag, int packageId) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// INDEXLIST REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createIndexListRequesr(String clientTag, int packageId) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// INDEXMEMBERLIST REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createIndexMemberListRequesr(
    String clientTag, int packageId, String indexName) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(indexName.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(indexName),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// ORDERBOOK REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createOrderBookRequesr(String clientTag, int packageId,
    String stockCode, String commant, String board) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(commant),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
  // final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
  // final int headerLength = PACKAGE_HEADER_LENGTH +
  //     8 +
  //     clientTag.length +
  //     commant.length +
  //     stockCode.length +
  //     board.length;
  // int readpos = 0;

  // Uint8List indexMemberListRequest = Uint8List(headerLength);
  // ByteData bb = indexMemberListRequest.buffer.asByteData();

  // Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  // for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
  //   bb.setUint8(i, packageHeader[i]);
  // }

  // readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

  // bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
  // for (int i = 0; i < clientTag.length; i++) {
  //   bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
  // }
  // readpos = readpos + clientTag.length + 2;

  // bb.setUint8(readpos, int.parse(commant));

  // readpos = readpos + 1;

  // bb.setUint16(readpos, stockCode.length);
  // for (int i = 0; i < stockCode.length; i++) {
  //   bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
  // }
  // readpos = readpos + stockCode.length + 2;

  // for (int i = 0; i < board.length; i++) {
  //   bb.setInt8(readpos + i, board.codeUnitAt(i));
  // }
  // // print(indexMemberListRequest);
  // return indexMemberListRequest;
}

// TODAY TRADE DATA REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestTodayTradesData(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String commant,
    String starttradeId,
    String nbreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(commant),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttradeId),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nbreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;

//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       15 +
//       clientTag.length +
//       stockCode.length +
//       board.length +
//       commant.length +
//       starttradeId.length +
//       nbreq.length;
//   int readpos = 0;
//   Uint8List todayTradesDataRequest = Uint8List(headerLength);
//   ByteData bb = todayTradesDataRequest.buffer.asByteData();

//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;

//   // stockcode

//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;

//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setInt8(readpos + i, board.codeUnitAt(i));
//   }
//   readpos = readpos + 2;

// // commant
//   bb.setUint8(readpos, int.parse(commant));
//   readpos = readpos + 1;
//   // start trade id
//   bb.setUint32(readpos, int.parse(starttradeId));

//   // NBrequest
//   bb.setUint32(readpos, int.parse(nbreq));

//   print(todayTradesDataRequest);
//   return todayTradesDataRequest;
}

// IDXNEWS REQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createIDXNewsRequest(String clientTag, int packageId, String newsdate,
    String command, String newsid, String nrequest) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(newsdate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(newsid),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nrequest),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// SUBSCRIBERUNNINGTRADE WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createSubscribeRunningTradesRequest(int packageId, String clientTag,
    String command, List<ArrayStockCode> array) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(set32(array.length)),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(makeArrayByte(array)),
  );

  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
  // final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
  // final int headerLength = PACKAGE_HEADER_LENGTH +
  //     10 +
  //     clientTag.length +
  //     command.length +
  //     encodeList.length;
  // int readpos = 0;
  // Uint8List runningtradesrequest = Uint8List(headerLength);
  // ByteData bb = runningtradesrequest.buffer.asByteData();
  // Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  // for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
  //   bb.setUint8(i, packageHeader[i]);
  // }
  // readpos = readpos + Constans.PACKAGE_HEADER_LENGTH; // clienttag
  // bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
  // for (int i = 0; i < clientTag.length; i++) {
  //   bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
  // }
  // readpos = readpos + clientTag.length + 2;
  // bb.setUint8(readpos, int.parse(command));
  // readpos = readpos + 1;
  // // array
  // bb.setUint32(readpos, array.length - 1);
  // readpos = readpos + 4;

  // for (int i = 0; i < encodeList.length; i++) {
  //   bb.setUint8(readpos + i, encodeList[i]);
  // }

  // return runningtradesrequest;
}

// DAILYHISTORYSTOCKSUMMARY WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createDailyHistoryStockSummary(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String commant,
    String starttradeId,
    String nbreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(commant),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttradeId),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nbreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       15 +
//       clientTag.length +
//       stockCode.length +
//       board.length +
//       commant.length +
//       starttradeId.length +
//       nbreq.length;
//   int readpos = 0;

//   Uint8List dailyTradesDataRequest = Uint8List(headerLength);
//   ByteData bb = dailyTradesDataRequest.buffer.asByteData();

//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;

//   // stockcode
//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;

//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setInt8(readpos + i, board.codeUnitAt(i));
//   }
//   readpos = readpos + 2;

// // commant
//   bb.setUint8(readpos, int.parse(commant));
//   readpos = readpos + 1;
//   // start trade id
//   bb.setUint32(readpos, int.parse(starttradeId));

//   // NBrequest
//   bb.setUint32(readpos, int.parse(nbreq));

//   print(dailyTradesDataRequest);
//   return dailyTradesDataRequest;
}

// SUBSCRIBEBROKERSUMMARY WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createSubscribeBrokerSummary(String clientTag, int packageId,
    String command, String stockCode, String board) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;

//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       8 +
//       clientTag.length +
//       command.length +
//       stockCode.length +
//       board.length;

//   int readpos = 0;

//   Uint8List subscribeBrokerSummary = Uint8List(headerLength);
//   ByteData bb = subscribeBrokerSummary.buffer.asByteData();

//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;

//   bb.setUint8(readpos, int.parse(command));
//   readpos = readpos + 1;
//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;
//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setUint8(readpos + i, board.codeUnitAt(i));
//   }

//   print(subscribeBrokerSummary);
//   return subscribeBrokerSummary;
}

// INI BELUM KELAR
Uint8List createRequestStockGroupList(
    String clientTag, int packageId, String clientId) {
  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  final int headerLength =
      packageHeaderLength + 10 + clientTag.length + clientId.length;

  int readpos = 0;
  Uint8List requestStockGroupList = Uint8List(headerLength);
  ByteData bb = requestStockGroupList.buffer.asByteData();

  Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  for (int i = 0; i < packageHeaderLength; i++) {
    bb.setUint8(i, packageHeader[i]);
  }
  readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
  // clienttag
  bb.setUint16(packageHeaderLength, clientTag.length);
  for (int i = 0; i < clientTag.length; i++) {
    bb.setUint8(packageHeaderLength + 2 + i, clientTag.codeUnitAt(i));
  }
  readpos = readpos + clientTag.length + 2;
  // ClietID
  bb.setUint16(readpos, clientId.length);
  for (int i = 0; i < clientId.length; i++) {
    bb.setUint8(readpos + 2 + i, clientId.codeUnitAt(i));
  }

  print(requestStockGroupList);
  return requestStockGroupList;
}

// TRADEBOOK WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createSubscribeTradeBook(String clientTag, int packageId,
    String command, String stockCode, String board) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;

//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       8 +
//       clientTag.length +
//       command.length +
//       stockCode.length +
//       board.length;
//   int readpos = 0;
//   Uint8List subscribeTradeBook = Uint8List(headerLength);
//   ByteData bb = subscribeTradeBook.buffer.asByteData();
//   // create header
//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;
// // command
//   bb.setUint8(readpos, int.parse(command));
//   readpos = readpos + 1;
// // stockcode
//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;
//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setUint8(readpos + i, board.codeUnitAt(i));
//   }

//   print(subscribeTradeBook);
//   return subscribeTradeBook;
}

// DAILYCHARTDATA WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestDailyChartData(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String commant,
    String starttingDate,
    String nrequest) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(commant),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nrequest),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       15 +
//       clientTag.length +
//       stockCode.length +
//       board.length +
//       commant.length +
//       starttingDate.length +
//       nrequest.length;
//   int readpos = 0;

//   Uint8List dailyChartData = Uint8List(headerLength);
//   ByteData bb = dailyChartData.buffer.asByteData();

//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
//   // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;
//   // stockcode

//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;

//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setInt8(readpos + i, board.codeUnitAt(i));
//   }
//   readpos = readpos + 2;

// // commant
//   bb.setUint8(readpos, int.parse(commant));
//   readpos = readpos + int.parse(commant);
//   // start trade id
//   bb.setUint32(readpos, int.parse(starttingDate));
//   readpos = readpos + 4;

//   // NBrequest
//   bb.setUint32(readpos, int.parse(nrequest));

//   return dailyChartData;
}

// WEEKLYCAHRTDATA WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestWeeklyChartData(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String command,
    String starttingDate,
    String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// MONTHLYCHARTDATA WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestMonthlyChartData(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String command,
    String starttingDate,
    String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// INTRADAYCHARTDATA WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestIntradayChartData(
    String clientTag,
    int packageId,
    String stockCode,
    String board,
    String command,
    String starttingDate,
    String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// DAILY INDEX CHART DATAS WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestDailyIndexChartDatas(String clientTag, int packageId,
    String indexCode, String command, String starttingDate, String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(indexCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(indexCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// WEEKLY INDEX CHART DATAS WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestweeklyIndexChartDatas(String clientTag, int packageId,
    String indexCode, String command, String starttingDate, String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(indexCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(indexCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// MONTHLY INDEX CHART DATAS WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestmonthlyIndexChartDatas(String clientTag, int packageId,
    String indexCode, String command, String starttingDate, String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(indexCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(indexCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// INTRADAY INDEX CHART DATAS WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createRequestintradayIndexChartDatas(String clientTag, int packageId,
    String indexCode, String command, String starttingDate, String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(indexCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(indexCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(starttingDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
}

// SUBSCRIBESUMMARY WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createSubscribeSummaryofForeignTransaction(
    String clientTag,
    int packageId,
    String command,
    String stockCode,
    String board,
    String startDate,
    String nreq) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(stockCode.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(stockCode),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(board),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(startDate),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(nreq),
      ),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       15 +
//       clientTag.length +
//       stockCode.length +
//       board.length +
//       command.length +
//       startDate.length +
//       nreq.length;
//   int readpos = 0;

//   Uint8List subscribesummaryofforeigntransactionRequest =
//       Uint8List(headerLength);
//   ByteData bb = subscribesummaryofforeigntransactionRequest.buffer.asByteData();
//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;

// // commant
//   bb.setUint8(readpos, int.parse(command));
//   readpos = readpos + 1;
//   // stockcode
//   bb.setUint16(readpos, stockCode.length);
//   for (int i = 0; i < stockCode.length; i++) {
//     bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
//   }
//   readpos = readpos + stockCode.length + 2;

//   // boardlength
//   for (int i = 0; i < board.length; i++) {
//     bb.setInt8(readpos + i, board.codeUnitAt(i));
//   }
//   readpos = readpos + 2;

//   // start trade id
//   bb.setUint32(readpos, int.parse(startDate));
//   readpos = readpos + 4;
//   // NBrequest
//   bb.setUint32(readpos, int.parse(nreq));

//   print(subscribesummaryofforeigntransactionRequest);
//   return subscribesummaryofforeigntransactionRequest;
}

// belum bisa ini
Uint8List createRegisterLoginIdRequest({
  required String clientTag,
  required String loginId,
  required String loginPassword,
  required String clinetName,
  String imei = "",
  String phoneNo = "",
}) {
  int xlength = clientTag.length +
      loginId.length +
      loginPassword.length +
      imei.length +
      phoneNo.length +
      10;
  // pastikan bahwa panjang data merupakan kelipatan 16
  if ((xlength % 16) != 0) {
    xlength = xlength + (16 - (xlength % 16));
  } // simpan data yang mau dikirim kedalam list of byte
  Uint8List data = Uint8List(xlength);
  ByteData bbData = data.buffer.asByteData();
  // clientTag
  bbData.setUint16(
      0, clientTag.length, Endian.big); // Client Tag Len	Unsigned Short	2
  for (int i = 0; i < clientTag.length; i++) {
    bbData.setUint8(
        2 + i, clientTag.codeUnitAt(i)); // Client Tag	Char	64	Max 63 chars
  }
  int offset = 2 + clientTag.length;
// loginId
  bbData.setUint16(
      offset, loginId.length, Endian.big); // Login Id Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < loginId.length; i++) {
    bbData.setUint8(
        offset + i, loginId.codeUnitAt(i)); // Login Id	char	30	Max 30 chars
  }
  offset += loginId.length;
  // loginpassword
  bbData.setUint16(offset, loginPassword.length,
      Endian.big); // Login Password Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < loginPassword.length; i++) {
    bbData.setUint8(
        offset + i,
        loginPassword
            .codeUnitAt(i)); // Login Password	Unsigned Short	15	Max 15 chars
  }
  offset += loginPassword.length;
  // clientname
  bbData.setUint16(
      offset, clinetName.length, Endian.big); // Login Id Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < clinetName.length; i++) {
    bbData.setUint8(
        offset + i, clinetName.codeUnitAt(i)); // Login Id	char	30	Max 30 chars
  }
  offset += clinetName.length;
  // imei
  bbData.setUint16(
      offset, imei.length, Endian.big); // IMEI Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < imei.length; i++) {
    bbData.setUint8(offset + i, imei.codeUnitAt(i)); // IMEI	char	64
  }

  offset += imei.length;
// phoneNo
  bbData.setUint16(
      offset, phoneNo.length, Endian.big); // PhoneNo Len	Unsigned Short	2
  offset += 2;
  for (int i = 0; i < phoneNo.length; i++) {
    bbData.setUint8(offset + i, phoneNo.codeUnitAt(i)); // Phone No	char	64
  }
  return createEncryptedMessage(Constans.PACKAGE_ID_LOGIN, data, xlength);
}

// QUOTESREQUEST WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createQuotesRequest(String clientTag, int packageId, String command,
    List<ArrayStockCode> array) {
  // Uint8List encodeList = makeArrayByte(array);
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(set32(array.length)),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(makeArrayByte(array)),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;
//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       20 +
//       clientTag.length +
//       command.length +
//       encodeList.length;
//   int readpos = 0;

//   Uint8List createQuotesRequest = Uint8List(headerLength);
//   ByteData bb = createQuotesRequest.buffer.asByteData();
//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;
//   bb.setUint8(readpos, int.parse(command));
//   readpos = readpos + 1;
//   int partialLength = (array.length / 2).ceil();
//   bb.setInt32(readpos, partialLength);
//   // readpos = readpos + 4;
//   for (int i = 0; i < encodeList.length; i++) {
//     bb.setUint8(readpos + i + 4, encodeList[i]);
//   }

//   return createQuotesRequest;
}

Uint8List createBrokerListforOrderRequest(
    String clientTag, int packageId, String loginId) {
  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  final int headerLength =
      packageHeaderLength + 8 + clientTag.length + loginId.length;
  int readpos = 0;

  Uint8List brokerlistfororder = Uint8List(headerLength);
  ByteData bb = brokerlistfororder.buffer.asByteData();
  Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  for (int i = 0; i < packageHeaderLength; i++) {
    bb.setUint8(i, packageHeader[i]);
  }
  readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
// clienttag
  bb.setUint16(packageHeaderLength, clientTag.length);
  for (int i = 0; i < clientTag.length; i++) {
    bb.setUint8(packageHeaderLength + 2 + i, clientTag.codeUnitAt(i));
  }
  readpos = readpos + clientTag.length + 2;
  // loginId
  bb.setUint16(
      readpos, loginId.length, Endian.big); // Login Id Len	Unsigned Short	2
  readpos += 2;
  for (int i = 0; i < loginId.length; i++) {
    bb.setUint8(
        readpos + i, loginId.codeUnitAt(i)); // Login Id	char	30	Max 30 chars
  }
  readpos += loginId.length;
  print(brokerlistfororder);
  return brokerlistfororder;
}

Uint8List createParameterRequest(String clientTag, int fraksi) {
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);

  int flag = 0;
  switch (fraksi) {
    case 0:
      flag |= (1 << 0);
      break;
    case 1:
      flag |= (1 << 1);
      break;
    case 2:
      flag |= (1 << 2);
      break;
  }

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(flag.toString()),
      ),
  );

  create = Uint8List.fromList(
    create.toList()
      ..addAll(
        createPackageHeader(
              createBody.length + Constans.PACKAGE_HEADER_LENGTH,
              Constans.PACKAGE_ID_DATA_PARAMETER,
            ) +
            createBody,
      ),
  );

  return create;
}

// SUBSCRIBE INDEX WITH DYNAMIC LENGTH BASED ON MSG => DONE
Uint8List createsubscribeIndexRequest(
    String clientTag, int packageId, String command, List<String> array) {
  Uint8List encodeList = Uint8List(0);
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  int iterationCount = 0;
  for (String element in array) {
    if (iterationCount % 4 <= 3) {
      int readspos = element.length;
      if (element.length >= 3) {
        encodeList = Uint8List.fromList(
            encodeList.toList()..addAll(encodeLength(readspos)));
        encodeList = Uint8List.fromList(
            encodeList.toList()..addAll(encodeString(element)));
      }
    }
    iterationCount++;
  }
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        int.parse(command),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(set32(array.length)),
  );
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(encodeList),
  );
  Uint8List packageHeader = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    packageId,
  );
  create = Uint8List.fromList(
    create.toList()..addAll(packageHeader + createBody),
  );
  return create;

//   final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//   final int headerLength = PACKAGE_HEADER_LENGTH +
//       20 +
//       clientTag.length +
//       command.length +
//       encodeList.length;
//   int readpos = 0;

//   Uint8List createIndexRequest = Uint8List(headerLength);
//   ByteData bb = createIndexRequest.buffer.asByteData();
//   Uint8List packageHeader = createPackageHeader(headerLength, packageId);
//   for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
//     bb.setUint8(i, packageHeader[i]);
//   }
//   readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
// // clienttag
//   bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
//   for (int i = 0; i < clientTag.length; i++) {
//     bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
//   }
//   readpos = readpos + clientTag.length + 2;
//   bb.setUint8(readpos, int.parse(command));
//   readpos = readpos + 1;
//   int partialLength = (array.length / 2).ceil();
//   bb.setInt32(readpos, partialLength);
//   // readpos = readpos + 4;
//   for (int i = 0; i < encodeList.length; i++) {
//     bb.setUint8(readpos + i + 4, encodeList[i]);
//   }

//   return createIndexRequest;
}

// ini belum fix
Uint8List createRequestStockGroupListMEMBER(
    String clientTag, int packageId, String clientId, List<String> array) {
  Uint8List encodeList = Uint8List(0);
  int iterationCount = 0;
  for (String element in array) {
    if (iterationCount % 4 <= 3) {
      int readspos = element.length;
      if (element.length >= 4) {
        encodeList = Uint8List.fromList(
            encodeList.toList()..addAll(encodeLength(readspos)));
        encodeList = Uint8List.fromList(
            encodeList.toList()..addAll(encodeString(element)));
      }
    }
    iterationCount++;
  }
  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  final int headerLength = packageHeaderLength +
      10 +
      clientTag.length +
      clientId.length +
      encodeList.length;
  int readpos = 0;

  Uint8List createStockGroupListMember = Uint8List(headerLength);
  ByteData bb = createStockGroupListMember.buffer.asByteData();
  Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  for (int i = 0; i < packageHeaderLength; i++) {
    bb.setUint8(i, packageHeader[i]);
  }
  readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
  // clienttag
  bb.setUint16(packageHeaderLength, clientTag.length);
  for (int i = 0; i < clientTag.length; i++) {
    bb.setUint8(packageHeaderLength + 2 + i, clientTag.codeUnitAt(i));
  }
  readpos = readpos + clientTag.length + 2;
  // clientID
  bb.setUint16(readpos, clientId.length);
  for (int i = 0; i < clientId.length; i++) {
    bb.setUint8(readpos + 2 + i, clientId.codeUnitAt(i));
  }
  readpos = readpos + clientId.length + 2;
  // array
  int partialLength = (array.length / 2).ceil();
  bb.setInt32(readpos, partialLength);
  // readpos = readpos + 4;
  for (int i = 0; i < encodeList.length; i++) {
    bb.setUint8(readpos + i + 4, encodeList[i]);
  }
  print(createStockGroupListMember);
  return createStockGroupListMember;
}

Uint8List CreateHashKeyRequest(
  String clientTag,
  int packageId, {
  // Definisikan bit yang ingin diatur menjadi 1
  bool hashStockList = true, // Bit 0
  bool hashBrokerList = true, // Bit 1
  bool hashIndexList = true, // Bit 2
  bool hashSectorList = true, // Bit 3
  bool hashFuturesList = true, // Bit 4
  bool hashOptionsList = true, // Bit 5
}) {
  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  final int headerLength = packageHeaderLength + 7 + clientTag.length;
  int readpos = 0;

  Uint8List createHashKeyRequest = Uint8List(headerLength);
  ByteData bb = createHashKeyRequest.buffer.asByteData();
  Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  for (int i = 0; i < packageHeaderLength; i++) {
    bb.setUint8(i, packageHeader[i]);
  }
  readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
  // clienttag
  bb.setUint16(packageHeaderLength, clientTag.length);
  for (int i = 0; i < clientTag.length; i++) {
    bb.setUint8(packageHeaderLength + 2 + i, clientTag.codeUnitAt(i));
  }
  readpos = readpos + clientTag.length + 2;
  int flags = 0;
  // flags = flags | (1 << hashFalg);
  if (hashStockList) flags |= (1 << 0);
  if (hashBrokerList) flags |= (1 << 1);
  if (hashIndexList) flags |= (1 << 2);
  if (hashSectorList) flags |= (1 << 3);
  if (hashFuturesList) flags |= (1 << 4);
  if (hashOptionsList) flags |= (1 << 5);

  bb.setUint8(readpos, flags);
  return createHashKeyRequest;
}

Uint8List CreateAddFavoritstock(String clientTag, int packageId,
    String clientId, List<String> arraygroupname, List<String> arrayStockCode) {
  Uint8List encodeListarraygroupname = Uint8List(0);
  int iterationCountarraygroupname = 0;
  for (String elementarraygroupname in arraygroupname) {
    if (iterationCountarraygroupname % 4 <= 3) {
      int readspos = elementarraygroupname.length;
      if (elementarraygroupname.length > 1) {
        encodeListarraygroupname = Uint8List.fromList(
            encodeListarraygroupname.toList()..addAll(encodeLength(readspos)));
        encodeListarraygroupname = Uint8List.fromList(
            encodeListarraygroupname.toList()
              ..addAll(encodeString(elementarraygroupname)));
      } else if (elementarraygroupname.length <= 1 ||
          elementarraygroupname.length == 1) {
        encodeListarraygroupname =
            Uint8List.fromList(encodeListarraygroupname.toList()..addAll([0]));
      }
    }
    iterationCountarraygroupname++;
  }
  Uint8List encodeList2arrayStockCode = Uint8List(4);
  int iterationCount2arrayStockCode = 0;
  ByteData getDa = encodeList2arrayStockCode.buffer.asByteData();
  getDa.setUint32(0, arrayStockCode.length);
  encodeListarraygroupname = Uint8List.fromList(
      encodeListarraygroupname.toList()..addAll(encodeList2arrayStockCode));
  for (String elementarrayStockCode in arrayStockCode) {
    if (iterationCount2arrayStockCode % 4 <= 3) {
      int readspos = elementarrayStockCode.length;
      if (elementarrayStockCode.length >= 4) {
        encodeListarraygroupname = Uint8List.fromList(
            encodeListarraygroupname.toList()..addAll(encodeLength(readspos)));
        encodeListarraygroupname = Uint8List.fromList(
            encodeListarraygroupname.toList()
              ..addAll(encodeString(elementarrayStockCode)));
      }
    }
    iterationCount2arrayStockCode++;
  }

  final int packageHeaderLength = Constans.PACKAGE_HEADER_LENGTH;
  final int headerLength = packageHeaderLength +
      20 +
      clientTag.length +
      clientId.length +
      encodeListarraygroupname.length;

  int readpos = 0;

  Uint8List createaddFav = Uint8List(headerLength);
  ByteData bb = createaddFav.buffer.asByteData();
  Uint8List packageHeader = createPackageHeader(headerLength, packageId);
  for (int i = 0; i < packageHeaderLength; i++) {
    bb.setUint8(i, packageHeader[i]);
  }
  readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;
  // clienttag
  bb.setUint16(packageHeaderLength, clientTag.length);
  for (int i = 0; i < clientTag.length; i++) {
    bb.setUint8(packageHeaderLength + 2 + i, clientTag.codeUnitAt(i));
  }
  readpos = readpos + clientTag.length + 2;
  // clientID
  bb.setUint16(readpos, clientId.length);
  for (int i = 0; i < clientId.length; i++) {
    bb.setUint8(readpos + 2 + i, clientId.codeUnitAt(i));
  }
  readpos = readpos + clientId.length + 2;

  // array
  int partialLength = (arraygroupname.length / 2).ceil();
  bb.setInt32(readpos, partialLength);
  readpos = readpos + 4;
  for (int i = 0; i < encodeListarraygroupname.length; i++) {
    bb.setUint8(readpos + i, encodeListarraygroupname[i]);
  }

  readpos = readpos + encodeListarraygroupname.length;

  print(createaddFav);
  return createaddFav;
}

Uint8List CreateMassageStockRangking(
    String clientTag, int packageId, String board, int reqType, int nReq) {
  int iBoards = 0;
  switch (board) {
    case 'RG':
      iBoards = 0;
      break;
    case 'TN':
      iBoards = 1;
      break;
  }

  int createL = Constans.PACKAGE_HEADER_LENGTH +
      clientTag.length +
      8 +
      iBoards.toString().length +
      reqType.toString().length +
      nReq.toString().length;

  Uint8List create = Uint8List(createL);
  ByteData byteData = create.buffer.asByteData();

  int byteOffset = 0;

  Uint8List createHeader = createPackageHeader(createL, packageId);
  for (int i = 0; i < Constans.PACKAGE_HEADER_LENGTH; i++) {
    byteData.setUint8(byteOffset + i, createHeader[i]);
  }
  byteOffset = byteOffset + Constans.PACKAGE_HEADER_LENGTH;
  byteData.setUint16(byteOffset, clientTag.length);
  byteOffset = byteOffset + 2;
  for (int i = 0; i < clientTag.length; i++) {
    byteData.setUint8(byteOffset + i, clientTag.codeUnitAt(i));
  }
  byteOffset = byteOffset + clientTag.length;
  byteData.setUint8(byteOffset, iBoards);
  byteOffset = byteOffset + 1;
  byteData.setUint8(byteOffset, reqType);
  byteOffset = byteOffset + 1;
  byteData.setUint32(byteOffset, nReq);

  return create;
}
