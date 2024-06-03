import 'package:flutter/material.dart';
import 'package:world_countries/world_countries.dart';

class ScreenReturn extends StatelessWidget {
  final NaturalLanguage detectedLang;
  final NaturalLanguage selectedLang;
  final String txtRecognized;
  final String txtTranslated;
  const ScreenReturn({
    super.key,
    required this.detectedLang,
    required this.selectedLang,
    required this.txtRecognized,
    required this.txtTranslated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoToText'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(detectedLang.namesNative.firstOrNull ??
                      selectedLang.name),
                ),
                Card(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      txtRecognized,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(selectedLang.namesNative.firstOrNull ??
                      selectedLang.name),
                ),
                Card(
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      txtTranslated,
                      style: const TextStyle(fontSize: 22),
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
