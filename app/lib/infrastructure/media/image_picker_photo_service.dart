import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/ports/photo_picker_port.dart';
import '../ai/gemma_model_config.dart';
import 'image_prep.dart';

class _PrepArgs {
  const _PrepArgs(this.bytes, this.maxSide, this.quality);
  final Uint8List bytes;
  final int maxSide;
  final int quality;
}

Uint8List _prepInIsolate(_PrepArgs args) {
  return ImagePrep.prepareForOnDevice(
    args.bytes,
    maxSide: args.maxSide,
    jpegQuality: args.quality,
  );
}

class ImagePickerPhotoService implements PhotoPickerPort {
  ImagePickerPhotoService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<Uint8List?> pickFromGallery() => _pick(ImageSource.gallery);

  @override
  Future<Uint8List?> pickFromCamera() => _pick(ImageSource.camera);

  Future<Uint8List?> _pick(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    if (file == null) return null;
    final raw = await file.readAsBytes();
    return compute(
      _prepInIsolate,
      _PrepArgs(
        raw,
        GemmaModelConfig.maxImageSide,
        GemmaModelConfig.jpegQuality,
      ),
    );
  }
}
