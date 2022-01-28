import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:default_country_code/Model/CountryCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultCountryCode {
  static const MethodChannel _channel =
      const MethodChannel('default_country_code');
  static Future<CountryCode?> detectSIMCountry(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("packages/default_country_code/countryCodes.json");
    var countryCode = countryCodeFromJson(data);
    final String? country = await _channel.invokeMethod('detectSIMCountry');

    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }

  static Future<CountryCode?> detectNetworkCountry(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("packages/default_country_code/countryCodes.json");
    var countryCode = countryCodeFromJson(data);
    final String? country = await _channel.invokeMethod('detectNetworkCountry');
    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }

  static Future<CountryCode?> detectLocaleCountry(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("packages/default_country_code/countryCodes.json");
    var countryCode = countryCodeFromJson(data);
    final String? country = await _channel.invokeMethod('detectLocaleCountry');
    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }
}
