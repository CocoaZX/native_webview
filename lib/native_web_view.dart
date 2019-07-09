import 'dart:async';

import 'package:flutter/services.dart';

class NativeWebView {
  static const MethodChannel _channel =
      const MethodChannel('native_web_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static showWebView(url) {
    _channel.invokeMethod('showWebView');
  }

  static hiddenWebView(){
    _channel.invokeMethod('hideWebView');
  }

}
