import 'dart:async';

import 'package:flutter/services.dart';

class EzGauge {
  static const MethodChannel _channel =
      const MethodChannel('ez_gauge');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
