import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../../domain/ports/photo_picker_port.dart';
import '../media/image_prep.dart';
import '../ai/gemma_model_config.dart';

class ImagePickerPhotoService implements PhotoPickerPort {
  ImagePickerPhotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<Uint8List?> pickFromGallery() => _pick(ImageSource.gallery);

  @override
  Future<Uint8List?> pickFromCamera() => _pick(ImageSource.camera);

  Future<Uint8List?> _pick(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    if (file == null) return null;
    final raw = await file.readAsBytes();
    return ImagePrep.prepareForOnDevice(
      raw,
      maxSide: GemmaModelConfig.maxImageSide,
      jpegQuality: GemmaModelConfig.jpegQuality,
    );
  }
}
