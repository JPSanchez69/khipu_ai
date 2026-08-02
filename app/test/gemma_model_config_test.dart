import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_model_config.dart';

void main() {
  test('fileType es litertlm (LiteRT-LM), no task', () {
    expect(GemmaModelConfig.fileType, ModelFileType.litertlm);
  });

  test('artefacto principal es Gemma 4 E2B litertlm', () {
    expect(GemmaModelConfig.fileName, 'gemma-4-E2B-it.litertlm');
    expect(GemmaModelConfig.repoId, 'litert-community/gemma-4-E2B-it-litert-lm');
    expect(GemmaModelConfig.modelType, ModelType.gemma4);
    expect(GemmaModelConfig.displayName, 'Gemma 4 E2B');
  });
}
