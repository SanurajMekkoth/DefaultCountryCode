
import 'dart:async';

import 'package:flutter/services.dart';

class DefaultCountryCode {
  static const MethodChannel _channel =
  const MethodChannel('default_country_code');

  static Future<String?> get detectSIMCountry async {
    final String? country = await _channel.invokeMethod('detectSIMCountry');
    return country;
  }

  static Future<String?> get detectNetworkCountry async {
    final String? country = await _channel.invokeMethod('detectNetworkCountry');
    return country;
  }

  static Future<String?> get detectLocaleCountry async {
    final String? country = await _channel.invokeMethod('detectLocaleCountry');
    return country;
  }
}
