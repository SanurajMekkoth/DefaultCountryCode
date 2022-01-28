import 'package:default_country_code/views/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
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
    var country = await DefaultCountryCode.detectSIMCountry(context);
    setState(() {
      _simCountry = country?.name ?? "";
    });
  }

  Future<void> getNetworkCountryCode() async {
    var country = await DefaultCountryCode.detectNetworkCountry(context);
    if (!mounted) return;
    setState(() {
      _networkCountry = country?.name ?? "";
    });
  }

  Future<void> getLocaleCountryCode() async {
    var country = await DefaultCountryCode.detectLocaleCountry(context);
    if (!mounted) return;
    setState(() {
      _localeCountry = country?.name ?? "";
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
              Text(
                'Country code name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  'SIM: $_simCountry\n\nNetwork: $_networkCountry\n\nLocale: $_localeCountry\n'),
              // ElevatedButton(onPressed: () {}, child: Text("Show Country Code")),
              CountryCodePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
