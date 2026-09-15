import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature and shared UI code does not bypass centralized design tokens', () {
    final violations = <String>[];
    final lib = Directory('lib');

    final forbidden = <String, RegExp>{
      'literal Color': RegExp(r'\bColor\(0x[0-9A-Fa-f]+\)'),
      'direct Material color': RegExp(r'\bColors\.[A-Za-z_]'),
      'direct Material icon': RegExp(r'\bIcons\.[A-Za-z_]'),
      'local TextStyle': RegExp(r'\bTextStyle\('),
      'literal font size': RegExp(r'fontSize\s*:\s*-?\d'),
      'direct font weight': RegExp(r'FontWeight\.w\d+'),
      'literal border radius': RegExp(
        r'(?:BorderRadius|Radius)\.circular\(\s*-?\d',
      ),
      'local box shadow': RegExp(r'\bBoxShadow\('),
      'local text shadow': RegExp(r'\bShadow\('),
      'literal asset path': RegExp(r'''['"]assets/'''),
      'literal named icon size': RegExp(r'\bsize\s*:\s*-?\d'),
      'literal width': RegExp(r'\bwidth\s*:\s*-?\d'),
      'literal height': RegExp(r'\bheight\s*:\s*-?\d'),
      'literal opacity': RegExp(r'\bopacity\s*:\s*0?\.\d'),
      'literal withOpacity': RegExp(r'withOpacity\(\s*0?\.\d'),
      'literal elevation': RegExp(r'\belevation\s*:\s*-?\d'),
    };

    for (final entity in lib.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;

      final normalized = entity.path.replaceAll('\\', '/');
      if (normalized.contains('/core/design_system/')) continue;
      if (normalized.contains('/core/theme/')) continue; // compatibility exports

      final source = entity.readAsStringSync();
      for (final entry in forbidden.entries) {
        if (entry.value.hasMatch(source)) {
          violations.add('${entry.key}: $normalized');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason: 'Design primitives must be added to core/design_system first.\n'
          '${violations.join('\n')}',
    );
  });
}
