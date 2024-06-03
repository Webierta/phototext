import "dart:async" show unawaited;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:world_countries/world_countries.dart';

import '../mlkit/identificacion_lenguaje.dart';
import '../mlkit/reconocimiento_texto.dart';
import '../mlkit/traduccion.dart';
import '../utils/language_system.dart';
import '../widgets/app_drawer.dart';
import '../widgets/image_preview.dart';
import 'screen_error.dart';
import 'screen_return.dart';

class ScreenShot extends StatefulWidget {
  const ScreenShot({super.key});
  @override
  State<ScreenShot> createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  late ReconocimientoTexto? reconocimientoTexto;
  late IdentificacionLenguaje? idLenguaje;
  late Traduccion? traduccion;

  late ImagePicker imagePicker;
  String? pickedImagePath;

  late LanguagePicker languagePicker;
  NaturalLanguage? get selectedLang => languagePicker.chosen?.firstOrNull;

  bool isRecognizing = false;
  String infoProcess = '';

  setLanguageSystem() async {
    NaturalLanguage languageSystem = await LanguageSystem().getSystemLang();
    setState(() {
      languagePicker = languagePicker.copyWith(
        chosen: [languageSystem],
      );
    });
  }

  @override
  void initState() {
    //List<NaturalLanguage> listaLangs = [...NaturalLanguage.list];
    //listaLangs.removeAt(0);
    languagePicker = const LanguagePicker().copyWith(onSelect: onSelect);
    setLanguageSystem();
    imagePicker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    reconocimientoTexto?.close();
    idLenguaje?.close();
    traduccion?.close();
    isRecognizing = false;
    infoProcess = '';
    super.dispose();
  }

  void onSelect(NaturalLanguage newLang) {
    setState(() {
      languagePicker = languagePicker.copyWith(
        chosen: selectedLang == newLang ? const [] : [newLang],
      );
    });
  }

  void selectLanguage() {
    unawaited(
      languagePicker.showInModalBottomSheet(context),
    );
  }

  Future<void> pickImageFromCamera() async {
    XFile? pickedFile;
    try {
      pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.notCamera)),
      );
    }

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? pickedFile;
    try {
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error Gallery')),
      );
    }

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }
  }

  void _setImage(File pickedImage) {
    setState(() {
      pickedImagePath = pickedImage.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('PhoToText'),
        actions: [
          selectedLang != null
              ? Text(
                  selectedLang!.namesNative.firstOrNull ?? selectedLang!.name,
                )
              : const SizedBox(),
          IconButton(
            onPressed: selectLanguage,
            icon: const Icon(Icons.language),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: isRecognizing
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 24),
                          Text(infoProcess),
                        ],
                      )
                    : ImagePreview(imagePath: pickedImagePath),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: pickImageFromCamera,
              icon: const Icon(
                Icons.camera,
                color: Colors.white,
                size: 38,
              ),
            ),
            IconButton(
              onPressed: pickImageFromGallery,
              icon: const Icon(
                Icons.image,
                color: Colors.white,
                size: 38,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: initProcess,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.translate,
          size: 38,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void initProcess() async {
    setState(() {
      isRecognizing = true;
      infoProcess = 'Procesando imagen...';
    });
    reconocimientoTexto = ReconocimientoTexto(imagePath: pickedImagePath);
    String? textoRecognized = await reconocimientoTexto?.imageProcess();
    if (textoRecognized == null) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScreenError(
            errorStep: 1,
            txt: 'Error en el reconocimiento de texto',
          ),
        ),
      );

      reset();
      return;
    }

    setState(() {
      infoProcess = 'Identificando idioma...';
    });
    idLenguaje = IdentificacionLenguaje(texto: textoRecognized);
    NaturalLanguage? sourceLang = await idLenguaje?.textDetect();
    if (sourceLang == null) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScreenError(
            errorStep: 2,
            txt: 'Error en la identificación del idioma',
            recognized: textoRecognized,
          ),
        ),
      );
      reset();
      return;
    }

    setState(() {
      infoProcess = 'Traduciendo texto...';
    });
    if (selectedLang == null) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScreenError(
            errorStep: 0,
            txt: 'Selecciona un idioma para traducir',
          ),
        ),
      );
      reset();
      return;
    }
    traduccion = Traduccion(
      source: sourceLang,
      target: selectedLang!,
      texto: textoRecognized,
    );
    String? textoTraducido = await traduccion?.inicio();
    if (textoTraducido == null || textoTraducido.isEmpty) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScreenError(
            errorStep: 3,
            txt: 'Error en la traducción',
            recognized: textoRecognized,
            idLang: sourceLang.name,
          ),
        ),
      );
      reset();
      return;
    }

    setState(() {
      isRecognizing = false;
      infoProcess = '';
    });

    if (selectedLang == null) {
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScreenError(
            errorStep: 0,
            txt: 'Selecciona un idioma para traducir',
          ),
        ),
      );
      reset();
      return;
    }

    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenReturn(
          detectedLang: sourceLang,
          selectedLang: selectedLang!,
          txtRecognized: textoRecognized,
          txtTranslated: textoTraducido,
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      isRecognizing = false;
      infoProcess = '';
    });
  }
}
