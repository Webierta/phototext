import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ReconocimientoTexto {
  final String? imagePath;

  TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer textRecognizerChinese =
      TextRecognizer(script: TextRecognitionScript.chinese);
  final TextRecognizer textRecognizerDevanagiri =
      TextRecognizer(script: TextRecognitionScript.devanagiri);
  final TextRecognizer textRecognizerJapanese =
      TextRecognizer(script: TextRecognitionScript.japanese);
  final TextRecognizer textRecognizerKorean =
      TextRecognizer(script: TextRecognitionScript.korean);

  ReconocimientoTexto({required this.imagePath});

  Future<String?> imageProcess() async {
    if (imagePath == null) {
      return null;
    }
    try {
      final inputImage = InputImage.fromFilePath(imagePath!);

      RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      if (recognizedText.text.trim().isEmpty) {
        textRecognizer = textRecognizerChinese;
        recognizedText = await textRecognizer.processImage(inputImage);
        if (recognizedText.text.trim().isEmpty) {
          textRecognizer = textRecognizerDevanagiri;
          recognizedText = await textRecognizer.processImage(inputImage);
          if (recognizedText.text.trim().isEmpty) {
            textRecognizer = textRecognizerJapanese;
            recognizedText = await textRecognizer.processImage(inputImage);
            if (recognizedText.text.trim().isEmpty) {
              textRecognizer = textRecognizerKorean;
              recognizedText = await textRecognizer.processImage(inputImage);
            }
          }
        }
      }

      //txtRecognized = recognizedText.text.replaceAll('\n', ' ');
      //return txtRecognized

      if (recognizedText.text.trim().isEmpty) {
        return null;
      }

      String txtRecognized = '';
      for (TextBlock block in recognizedText.blocks) {
        //List<String> languages = block.recognizedLanguages;
        for (TextLine line in block.lines) {
          txtRecognized += '${line.text} ';
        }
        txtRecognized += '\n';
      }

      if (txtRecognized.trim().isEmpty) {
        return null;
      }
      //return txtRecognized.replaceAll('\n', ' ');
      return txtRecognized.trimRight();
    } catch (e) {
      return null;
    }
  }

  close() {
    textRecognizer.close();
  }
}
