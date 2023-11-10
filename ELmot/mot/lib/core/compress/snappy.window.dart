import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

typedef UncompressDataC = Pointer<Uint8> Function(
  Pointer<Uint8> buffCompressed,
  IntPtr buffCompressedLength,
  IntPtr originalLength,
  Pointer<Uint64> outputLen,
);
typedef UncompressDataDart = Pointer<Uint8> Function(
  Pointer<Uint8> buffCompressed,
  int buffCompressedLength,
  int originalLength,
  Pointer<Uint64> outputLen,
);
final DynamicLibrary nativeLibrary = DynamicLibrary.open('snappy.dll');

class SnappyCompressionWindows {
  static Future<Uint8List> decompress(
      Uint8List compressedBuff, int originalLength) async {
    // Call decompress void
    final uncompressDataC = nativeLibrary
        .lookupFunction<UncompressDataC, UncompressDataDart>("uncompressData");
    // BATAS
    int lengthCompressedBuff = compressedBuff.length;
    final inputBuffer = calloc<Uint8>(compressedBuff.length);
    final outputLenPointer = calloc<Uint64>();
    inputBuffer.asTypedList(compressedBuff.length).setAll(0, compressedBuff);
    final decompressFunction = uncompressDataC(
        inputBuffer, lengthCompressedBuff, originalLength, outputLenPointer);
    int outputLen = outputLenPointer.value;
    Uint8List decompressedBufList = decompressFunction.asTypedList(outputLen);
    calloc.free(inputBuffer);
    calloc.free(outputLenPointer);
    return decompressedBufList;
  }
}
