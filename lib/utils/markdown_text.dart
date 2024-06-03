import '../l10n/markdown_about.dart';
import '../l10n/markdown_info.dart';
import '../l10n/markdown_support.dart';

class MarkdownText {
  final String codeLangApp;

  MarkdownText({required this.codeLangApp});

  String get info {
    switch (codeLangApp) {
      case 'EN':
        return MarkdownInfo.en;
      case 'ES':
        return MarkdownInfo.es;
      default:
        return MarkdownInfo.en;
    }
  }

  String get about {
    switch (codeLangApp) {
      case 'EN':
        return MarkdownAbout.en;
      case 'ES':
        return MarkdownAbout.es;
      default:
        return MarkdownAbout.en;
    }
  }

  String get support {
    switch (codeLangApp) {
      case 'EN':
        return MarkdownSupport.en;
      case 'ES':
        return MarkdownSupport.es;
      default:
        return MarkdownSupport.en;
    }
  }
}
