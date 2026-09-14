import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('audio assets can be found in bundle', () async {
    final tahaByteData = await rootBundle.load('assets/audio/taha_manqus-c.mp3');
    expect(tahaByteData.lengthInBytes, greaterThan(1000000));

    final arifByteData = await rootBundle.load('assets/audio/arif-c.mp3');
    expect(arifByteData.lengthInBytes, greaterThan(1000000));
  });

  test('image assets can be found in bundle', () async {
    final thahaImg = await rootBundle.load('assets/images/thaha_tangal.png');
    expect(thahaImg.lengthInBytes, greaterThan(1000));

    final arifImg = await rootBundle.load('assets/images/arif_sadi.png');
    expect(arifImg.lengthInBytes, greaterThan(1000));
  });
}
