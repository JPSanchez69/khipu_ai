import 'dart:typed_data';

/// Selección de foto (cámara o galería).
abstract interface class PhotoPickerPort {
  Future<Uint8List?> pickFromGallery();
  Future<Uint8List?> pickFromCamera();
}
