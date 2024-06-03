import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownStyle {
  static MarkdownStyleSheet buildMarkdownStyleSheet() {
    return MarkdownStyleSheet(
      h1: const TextStyle(
        color: Color(0xFFB0BEC5),
        fontSize: 40,
        fontWeight: FontWeight.w200,
      ),
      h2: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 22),
      //h3: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 20),
      p: const TextStyle(fontSize: 18),
      blockquoteDecoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      blockSpacing: 20,
      horizontalRuleDecoration: BoxDecoration(
        border: Border.all(
          width: 0.8,
          color: Colors.white30,
        ),
        //borderRadius: BorderRadius.circular(12),
      ),
      //textAlign: WrapAlignment.center,
      h6Align: WrapAlignment.center,
    );
  }
}
