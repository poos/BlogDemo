import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login/login.dart';

void main() {
  const MethodChannel channel = MethodChannel('login');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Login.platformVersion, '42');
  });
}
