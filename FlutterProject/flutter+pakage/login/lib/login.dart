import 'dart:async';

import 'package:flutter/services.dart';

class Login {
  static const MethodChannel _channel =
      const MethodChannel('login');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  static Future<String> get aaaaa async {
    final String version = await _channel.invokeMethod('aaaaa');
    return version;
  }


  static Future<String> get getBatteryLevel async {
    final String version = await _channel.invokeMethod('getBatteryLevel');
    return version;
  }
  

  static Future<String> get login async {
    final String version = await _channel.invokeMethod('login');
    return version;
  }
}
