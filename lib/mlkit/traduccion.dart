import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:world_countries/world_countries.dart';

class Traduccion {
  final NaturalLanguage source;
  final NaturalLanguage target;
  final String texto;

  OnDeviceTranslator? onDeviceTranslator;

  Traduccion({required this.source, required this.target, required this.texto});

  Future<String?> inicio() async {
    try {
      TranslateLanguage? sourceLanguage = TranslateLanguage.values
          .where((lang) => lang.bcpCode == source.codeShort.toLowerCase())
          .toList()
          .firstOrNull;
      TranslateLanguage? targetLanguage = TranslateLanguage.values
          .where((lang) => lang.bcpCode == target.codeShort.toLowerCase())
          .toList()
          .firstOrNull;

      if (sourceLanguage == null || targetLanguage == null) {
        return null;
      }
      onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );

      final List<String> bloques = texto.split('\n');
      String traducido = '';
      for (String bloque in bloques) {
        var trad = await onDeviceTranslator?.translateText(bloque);
        if (trad != null) {
          //traducido = traducido + '\n' + trad;
          traducido += '$trad\n';
        }
      }
      if (traducido.trim().isEmpty) {
        return null;
      }
      return traducido.trimRight();

      /* final String? traducido = await onDeviceTranslator?.translateText(texto);
      if (traducido == null || traducido.isEmpty) {
        return null;
      }
      return traducido; */
    } catch (e) {
      return null;
    }
  }

  close() {
    onDeviceTranslator?.close();
  }
}
