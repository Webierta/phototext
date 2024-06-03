import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/markdown_style.dart';
import '../styles/styles.dart';
import '../utils/idioma_provider.dart';
import '../utils/markdown_text.dart';

const String btcAddress = '15ZpNzqbYFx9P7wg4U438JMwZr2q3W6fkS';
const String urlPayPal =
    'https://www.paypal.com/donate?hosted_button_id=986PSAHLH6N4L';
const String urlGitHub = 'https://github.com/Webierta/tarifa_luz/issues';

class ScreenSupport extends StatelessWidget {
  const ScreenSupport({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Buy Me a Coffee'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: AppStyle.boxDecoGradient,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Markdown(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  data: MarkdownText(
                          codeLangApp: context
                              .watch<IdiomaProvider>()
                              .appLanguage
                              .codeShort)
                      .support,
                  onTapLink: (text, url, title) {
                    launchWeb(url!);
                  },
                  styleSheet: MarkdownStyle.buildMarkdownStyleSheet(),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(8.0),
                          decoration: ShapeDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.zero,
                                topRight: Radius.zero,
                              ),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              btcAddress,
                              style: TextStyle(color: Color(0xFF455A64)),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () async {
                              await Clipboard.setData(
                                const ClipboardData(text: btcAddress),
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('BTC Address copied to Clipboard.'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
