import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:default_country_code/default_country_code.dart';

void main() {
  const MethodChannel channel = MethodChannel('default_country_code');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DefaultCountryCode.detectNetworkCountry, '42');
  });
}
