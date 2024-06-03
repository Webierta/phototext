import 'package:flutter/material.dart';

const Icon iconDon = Icon(Icons.check_box, color: Colors.green);
const Icon iconBug = Icon(Icons.disabled_by_default, color: Colors.red);
const Icon iconBox = Icon(Icons.square);

class ScreenError extends StatelessWidget {
  final int errorStep;
  final String txt;
  final String? recognized;
  final String? idLang;

  const ScreenError({
    super.key,
    required this.errorStep,
    required this.txt,
    this.recognized,
    this.idLang,
  });

  Icon getIcon(int step) {
    if (step == 1) {
      if (errorStep == 1) {
        return iconBug;
      } else if (errorStep > 1) {
        return iconDon;
      }
    } else if (step == 2) {
      if (errorStep == 1) {
        return iconBox;
      } else if (errorStep == 2) {
        return iconBug;
      } else if (errorStep > 2) {
        return iconDon;
      }
    } else if (step == 3) {
      if (errorStep < 3) {
        return iconBox;
      } else if (errorStep == 3) {
        return iconBug;
      }
    }
    return iconBox;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 0.5, 0.8, 0.7],
              colors: [
                Color(0xFF02121D),
                Color(0xFF284964),
                Color(0xFF61778A),
                Color(0xFFA4AFB8),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.red,
                        size: 44,
                      ),
                      Text(
                        'Proceso abortado',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        txt,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: getIcon(1),
                        title: const Text('Reconocimiento de texto'),
                        subtitle: recognized == null ? null : Text(recognized!),
                        subtitleTextStyle:
                            const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      ListTile(
                        leading: getIcon(2),
                        title: const Text('Identificación de idioma'),
                        subtitle: idLang == null ? null : Text(idLang!),
                      ),
                      ListTile(
                        leading: getIcon(3),
                        title: const Text('Traducción'),
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
