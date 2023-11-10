import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';

Uint8List bufs = bufs;
String run = routkey;

// Izin edit encrypt.dart untuk coba-coba
class Encrypt {
  //Encrypt 2 bit (getUShort)

  int encrypt2(Uint8List bytes, int offset) {
    int value = (bytes[offset] << 8) | bytes[offset + 1];
    return value;
  }

  // int getPackage2Bit(Uint8List bytes, int offset) {
  //   int value =
  //       ByteData.sublistView(bytes.sublist(offset)).getUint16(0, Endian.big);
  //   return value;
  // }

  //Encrypt 4 bit (getUInt)
  int encrypt4(Uint8List bytes, int offset) {
    int value = (bytes[offset] << 24) |
        (bytes[offset + 1] << 16) |
        (bytes[offset + 2] << 8) |
        bytes[offset + 3];
    return value;
  }

//Encrypt Long 8 Byte
  int getLong(ByteBuffer bb, int pos) {
    ByteData data = bb.asByteData();
    return data.getInt64(pos, Endian.big);
  }

// 4 byte
  int getInt(Uint8List bytes, int offset) {
    ByteBuffer get = Uint8List.fromList(bytes).buffer;
    int v = ByteData.view(get).getInt32(offset);
    return v;
  }

//Encrypt Get 1byte
  int get(Uint8List bytes, int offset) {
    return bytes[offset];
  }

  //Encrypt String to binry (getAsciiBytes)
  static Uint8List getAsciiBytes(String value) {
    return Uint8List.fromList(utf8.encode(value));
  }

  //Encrypt binry to String (getAsciiString)
  String getAsciiString(Uint8List bytes, int offset, int len) {
    // Extract the desired portion of the originalData
    Uint8List asciiBytes = bytes.sublist(offset, offset + len);
    // Convert the asciiBytes to a string
    String asciiString = String.fromCharCodes(asciiBytes);
    return asciiString;
  }
}

class EncryptControll extends GetxController {
  RxInt readPos = 0.obs;

  dynamic encrypt1(Uint8List buf) {
    int value = buf[readPos.value];
    readPos.value = readPos.value + 1;
    return value;
  }

  dynamic encrypt2(Uint8List buf) {
    int value = (buf[readPos.value] << 8) | buf[readPos.value + 1];
    readPos.value = readPos.value + 2;
    return value;
  }

  dynamic encrypt4(Uint8List buf) {
    int value = (buf[readPos.value] << 24) |
        (buf[readPos.value + 1] << 16) |
        (buf[readPos.value + 2] << 8) |
        buf[readPos.value + 3];
    readPos.value = readPos.value + 4;
    return value;
  }

  dynamic encrypt8(Uint8List buf) {
    int value = (buf[readPos.value] << 56) |
        (buf[readPos.value + 1] << 48) |
        (buf[readPos.value + 2] << 40) |
        (buf[readPos.value + 3] << 32) |
        (buf[readPos.value + 4] << 24) |
        (buf[readPos.value + 5] << 16) |
        (buf[readPos.value + 6] << 8) |
        buf[readPos.value + 7];
    readPos.value = readPos.value + 8;
    return value;
  }

  dynamic getAsciiString(Uint8List buf, int len) {
    Uint8List asciiBytes = buf.sublist(readPos.value, readPos.value + len);
    String asciiString = String.fromCharCodes(asciiBytes);
    readPos.value = readPos.value + len;
    return asciiString;
  }

  dynamic getDouble(Uint8List buf) {
    int value = ByteData.sublistView(buf).getInt32(readPos.value, Endian.big);
    readPos.value = readPos.value + 4;
    return value;
  }

  dynamic getDouble8(Uint8List buf) {
    int value = ByteData.sublistView(buf).getInt64(readPos.value, Endian.big);
    readPos.value = readPos.value + 8;
    return value;
  }
}
