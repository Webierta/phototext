import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/markdown_style.dart';
import '../styles/styles.dart';
import '../utils/idioma_provider.dart';
import '../utils/markdown_text.dart';

class ScreenInfo extends StatelessWidget {
  const ScreenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    //final AppLocalizations l10n = AppLocalizations.of(context)!;

    Future<void> launchWeb(String url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not launch $url'),
        ));
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Info'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: AppStyle.boxDecoGradient,
          child: Markdown(
            padding: const EdgeInsets.symmetric(vertical: 20),
            data: MarkdownText(
                    codeLangApp:
                        context.watch<IdiomaProvider>().appLanguage.codeShort)
                .info,
            onTapLink: (text, url, title) {
              launchWeb(url!);
            },
            styleSheet: MarkdownStyle.buildMarkdownStyleSheet(),
          ),
        ),
      ),
    );
  }
}
