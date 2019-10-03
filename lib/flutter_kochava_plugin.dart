import 'dart:async';
import 'package:flutter/services.dart';
import 'kochava_event.dart';
export 'kochava_event.dart';

class FlutterKochavaPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_kochava_plugin');

  static Future<void> configure({String key}) async {
    try {
      final String result = await _channel.invokeMethod('configure', key);
      return result;
    } on PlatformException catch (e) {
      throw ("error '${e.message}'");
    }
  }

  static Future<void> sendEvent(KochavaEvent event) async {
    try {
      final String result =
          await _channel.invokeMethod('sendEvent', event.toDict());
      return result;
    } on PlatformException catch (e) {
      throw ("error '${e.message}'");
    }
  }
}
