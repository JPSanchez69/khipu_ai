import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:khipu_ai/infrastructure/media/image_prep.dart';

Uint8List _png(int w, int h) {
  final image = img.Image(width: w, height: h);
  img.fill(image, color: img.ColorRgb8(20, 120, 80));
  return Uint8List.fromList(img.encodePng(image));
}

void main() {
  group('ImagePrep', () {
    test('reduce lado largo a maxSide y entrega JPEG', () {
      final raw = _png(1600, 900);
      final out = ImagePrep.prepareForOnDevice(
        raw,
        maxSide: 640,
        jpegQuality: 70,
      );
      final decoded = img.decodeJpg(out);
      expect(decoded, isNotNull);
      expect(decoded!.width, lessThanOrEqualTo(640));
      expect(decoded.height, lessThanOrEqualTo(640));
      // Lado largo original 1600 → debe bajar a ≤640.
      expect(
        decoded.width > decoded.height ? decoded.width : decoded.height,
        640,
      );
    });

    test('imagen ya pequeña no crece de lado', () {
      final raw = _png(200, 150);
      final out = ImagePrep.prepareForOnDevice(raw, maxSide: 640);
      final decoded = img.decodeJpg(out)!;
      expect(decoded.width, 200);
      expect(decoded.height, 150);
    });

    test('bytes inválidos lanzan', () {
      expect(
        () => ImagePrep.prepareForOnDevice(Uint8List.fromList([1, 2, 3])),
        throwsA(isA<ImagePrepException>()),
      );
    });
  });
}
