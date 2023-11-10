// import 'dart:typed_data';

// import 'package:online_trading/helper/constants.dart';

// class ReadPackage {
//   Uint8List buf;
//   int readPos = Constans.PACKAGE_HEADER_LENGTH;
//   ReadPackage({required this.buf});

// //GetSting pkg Name
//   String getString(int slen) {
//     final bufL = Uint8List.fromList(buf);
//     if (slen == 0) {
//       return "";
//     }
//     List<int> strBytes = bufL.sublist(readPos, readPos + slen);
//     String str = String.fromCharCodes(strBytes);
//     readPos += slen;
//     return str.trim();
//   }

//   int getInt16() {
//     int v = ByteData.view(buf.buffer).getUint16(readPos);
//     readPos += 2;
//     return v;
//   }
// }
