import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:world_countries/world_countries.dart';

class IdentificacionLenguaje {
  final String texto;
  final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

  IdentificacionLenguaje({required this.texto});

  Future<NaturalLanguage?> textDetect() async {
    try {
      String idLanguage = await languageIdentifier.identifyLanguage(texto);
      if (idLanguage == 'und') {
        return null;
      }
      return NaturalLanguage.fromCodeShort(idLanguage.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  close() {
    languageIdentifier.close();
  }
}
