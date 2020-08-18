import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ez_gauge/ez_gauge.dart';

void main() {
  const MethodChannel channel = MethodChannel('ez_gauge');

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
    expect(await EzGauge.platformVersion, '42');
  });
}
