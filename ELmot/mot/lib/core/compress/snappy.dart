import 'dart:async';

import 'package:flutter/services.dart';

class SnappyCompression {
  static const MethodChannel _channel =
      MethodChannel('com.example.snappy/compression');

  static Future<Uint8List> compress(Uint8List data) async {
    try {
      final Uint8List result = await _channel.invokeMethod('compress', data);
      return result;
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
    return Uint8List(0);
  }

  static Future<Uint8List> decompress(Uint8List data) async {
    try {
      final mapData = {
        'byte': data,
      };
      final Uint8List result =
          await _channel.invokeMethod('decompress', mapData);
      return result;
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
    return Uint8List(0);
  }
}
