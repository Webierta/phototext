import 'package:flutter/material.dart';

class AppStyle {
  static const BoxDecoration boxDecoGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.2, 0.5, 0.9, 0.7],
      colors: [
        Color(0xFF02121D),
        Color(0xFF284964),
        Color(0xFF61778A),
        Color(0xFFA4AFB8),
      ],
    ),
  );
}
