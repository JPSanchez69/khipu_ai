import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_model_config.dart';

void main() {
  test('fileType es task (MediaPipe), no litertlm', () {
    expect(GemmaModelConfig.fileType, ModelFileType.task);
  });

  test('artefacto principal es Gemma 3 1B-IT int4', () {
    expect(GemmaModelConfig.fileName, 'gemma3-1b-it-int4.task');
    expect(GemmaModelConfig.repoId, 'litert-community/Gemma3-1B-IT');
    expect(GemmaModelConfig.maxTokens, 2048);
    expect(GemmaModelConfig.maxOutputTokens, 384);
  });
}
