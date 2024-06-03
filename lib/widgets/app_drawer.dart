import 'package:flutter/material.dart';

import '../screens/screen_about.dart';
import '../screens/screen_info.dart';
import '../screens/screen_settings.dart';
import '../screens/screen_support.dart';
import '../styles/styles.dart';
import '../utils/constants.dart' as constant;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: AppStyle.boxDecoGradient,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'PHOTOTEXT',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w100,
                                  ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'TEXT RECOGNITION | LANG ID | TRANSLATION',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: const Color(0xFFFFFFFF)),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Copyleft 2024',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: const Color(0xFFFFFFFF)),
                        ),
                        Text(
                          'Jesús Cuerda (Webierta)',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: const Color(0xFFFFFFFF)),
                        ),
                        Text(
                          'All Wrongs Reserved. Licencia GPLv3',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: const Color(0xFFFFFFFF)),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Inicio'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Ajustes'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenSettings(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: Colors.white10),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Info'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenInfo(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('About'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenAbout(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_cafe_outlined),
                    title: const Text('Donar'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenSupport(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black12),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Versión ${constant.version}',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
