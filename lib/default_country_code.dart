import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:default_country_code/Model/CountryCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultCountryCode {
  static const MethodChannel _channel =
      const MethodChannel('default_country_code');

  static final List<CountryCode> _countryCodes = [];

  static Completer<List<CountryCode>>? _completer;

  static bool get isLoading => _completer != null;

  static Future<List<CountryCode>> getCountryCodes(BuildContext context) async {
    if (isLoading) {
      return _completer!.future;
    }
    _completer = Completer();
    String data = await DefaultAssetBundle.of(context)
        .loadString("packages/default_country_code/countryCodes.json");
    var codes = countryCodeFromJson(data);
    _countryCodes.addAll(codes);
    _completer!.complete(_countryCodes);
    return _completer!.future;
  }

  static Future<CountryCode?> detectSIMCountry(BuildContext context) async {
    var countryCode = await getCountryCodes(context);
    final String? country = await _channel.invokeMethod('detectSIMCountry');
    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }

  static Future<CountryCode?> detectNetworkCountry(BuildContext context) async {
    var countryCode = await getCountryCodes(context);
    final String? country = await _channel.invokeMethod('detectNetworkCountry');
    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }

  static Future<CountryCode?> detectLocaleCountry(BuildContext context) async {
    var countryCode = await getCountryCodes(context);
    final String? country = await _channel.invokeMethod('detectLocaleCountry');
    return countryCode
        .where((element) => element.code == country?.toUpperCase())
        .first;
  }
}
