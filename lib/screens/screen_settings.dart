import "dart:async" show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:world_countries/world_countries.dart';

import '../styles/styles.dart';
import '../utils/idioma.dart';
import '../utils/idioma_provider.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  late LanguagePicker languagePicker;
  NaturalLanguage get appLang =>
      languagePicker.chosen?.firstOrNull ?? NaturalLanguage.fromCodeShort('EN');

  @override
  void initState() {
    languagePicker =
        LanguagePicker(languages: Idioma.locales).copyWith(onSelect: onSelect);
    super.initState();
  }

  void onSelect(NaturalLanguage newLang) {
    languagePicker = languagePicker.copyWith(
      chosen: appLang == newLang ? const [] : [newLang],
    );
    context.read<IdiomaProvider>().setAppLanguage(newLang);

    /* setState(() {
      languagePicker = languagePicker.copyWith(
        chosen: selectedLang == newLang ? const [] : [newLang],
      );
    }); */
  }

  void selectAppLanguage() {
    unawaited(
      //languagePicker.showInModalBottomSheet(context),
      //languagePicker.showInDialog(context),
      languagePicker.showInSearch(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    List<NaturalLanguage> idiomas = Idioma.locales;
    debugPrint('${idiomas.first.name}  ${idiomas.last.name}');

    //IdiomaProvider idiomaProvider = Provider.of<IdiomaProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Container(
          decoration: AppStyle.boxDecoGradient,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: IconButton(
                          onPressed: selectAppLanguage,
                          icon: const Icon(Icons.language),
                        ),
                        title: Text(l10n.appLanguage),
                        subtitle: Text(
                            context.watch<IdiomaProvider>().appLanguage.name),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
