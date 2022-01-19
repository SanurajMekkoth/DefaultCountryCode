import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:default_country_code/default_country_code.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _simCountry = 'Unknown';
  String _networkCountry = 'Unknown';
  String _localeCountry = 'Unknown';

  @override
  void initState() {
    super.initState();
    getSimCountryCode();
    getNetworkCountryCode();
    getLocaleCountryCode();
  }

  Future<void> getSimCountryCode() async {
    String country;
    try {
      country =
          await DefaultCountryCode.detectSIMCountry ?? 'Unknown Country code';
    } on PlatformException {
      country = 'Failed to get country code.';
    }
    if (!mounted) return;
    setState(() {
      _simCountry = country;
    });
  }

  Future<void> getNetworkCountryCode() async {
    String country;
    try {
      country =
          await DefaultCountryCode.detectNetworkCountry ?? 'Unknown Country code';
    } on PlatformException {
      country = 'Failed to get country code.';
    }

    if (!mounted) return;

    setState(() {
      _networkCountry = country;
    });
  }


  Future<void> getLocaleCountryCode() async {
    String country;
    try {
      country =
          await DefaultCountryCode.detectLocaleCountry ?? 'Unknown Country code';
    } on PlatformException {
      country = 'Failed to get country code.';
    }

    if (!mounted) return;
    setState(() {
      _localeCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country code plugin'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Country code name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 20,),
              Text('SIM: $_simCountry\n\nNetwork: $_networkCountry\n\nLocale: $_localeCountry\n'),
            ],
          ),
        ),
      ),
    );
  }
}
