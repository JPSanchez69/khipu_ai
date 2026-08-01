import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khipu_ai/infrastructure/ai/gemma_model_config.dart';

void main() {
  test('fileType es litertlm (LiteRT-LM), no task', () {
    expect(GemmaModelConfig.fileType, ModelFileType.litertlm);
  });

  test('presupuesto de contexto con imagen es mayor', () {
    expect(
      GemmaModelConfig.maxTokensWithImage,
      greaterThan(GemmaModelConfig.maxTokens),
    );
  });
}
