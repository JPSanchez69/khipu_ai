import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Prepara fotos para inferencia on-device (lado máx. + JPEG).
class ImagePrep {
  ImagePrep._();

  static const defaultMaxSide = 640;
  static const defaultJpegQuality = 75;

  /// Redimensiona si el lado largo supera [maxSide] y re-encodea a JPEG.
  static Uint8List prepareForOnDevice(
    Uint8List bytes, {
    int maxSide = defaultMaxSide,
    int jpegQuality = defaultJpegQuality,
  }) {
    late final img.Image decoded;
    try {
      final result = img.decodeImage(bytes);
      if (result == null) {
        throw ImagePrepException('No se pudo decodificar la imagen');
      }
      decoded = result;
    } catch (e) {
      if (e is ImagePrepException) rethrow;
      throw ImagePrepException('No se pudo decodificar la imagen: $e');
    }

    img.Image sized = decoded;
    final longSide =
        decoded.width > decoded.height ? decoded.width : decoded.height;
    if (longSide > maxSide) {
      sized = img.copyResize(
        decoded,
        width: decoded.width >= decoded.height ? maxSide : null,
        height: decoded.height > decoded.width ? maxSide : null,
        interpolation: img.Interpolation.average,
      );
    }

    final jpeg = img.encodeJpg(sized, quality: jpegQuality);
    return Uint8List.fromList(jpeg);
  }
}

class ImagePrepException implements Exception {
  ImagePrepException(this.message);
  final String message;

  @override
  String toString() => 'ImagePrepException: $message';
}
