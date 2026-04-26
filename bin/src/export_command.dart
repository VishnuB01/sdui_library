import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

/// Handles the `dart run sdui export <file_name> <key_value>` command.
///
/// ### Strategy (code-gen + subprocess)
///
/// 1. Locate `<file_name>.dart` recursively under `lib/`.
/// 2. Write a temporary runner script to `.dart_tool/sdui_runner.dart`.
/// 3. Run the script with `dart run`, which:
///    a. Imports the user's DSL file (causing all top-level vars to init).
///    b. Looks up the node by key in `SduiRegistry`.
///    c. Calls `toJson()` and prints the result to stdout.
/// 4. Capture stdout → pretty-print → write to `exported_json/<file_name>.json`.
class ExportCommand {
  final String fileName;
  final String keyValue;

  const ExportCommand({required this.fileName, required this.keyValue});

  void run() {
    _log('🔍  Searching for "$fileName.dart" under lib/ ...');

    // ── 1. Locate the DSL source file ─────────────────────────────────────────
    final sourceFile = _findSourceFile();
    if (sourceFile == null) {
      _err('Could not find "$fileName.dart" under lib/');
      exit(1);
    }
    _log('   Found: ${sourceFile.path}');

    // ── 2. Create Temp Mock File ──────────────────────────────────────────────
    final tempSourceFile = _createTempSource(sourceFile);

    // ── 3. Write the temp runner script ───────────────────────────────────────
    final runnerFile = _writeRunner(tempSourceFile);
    _log('📝  Generated runner at ${runnerFile.path}');

    // ── 4. Execute the runner ─────────────────────────────────────────────────
    _log('⚙️   Running export for key "$keyValue" ...\n');
    final result = Process.runSync('dart', [
      'run',
      runnerFile.path,
    ], workingDirectory: Directory.current.path);

    // Clean up the runner and temp file regardless of outcome
    try {
      runnerFile.deleteSync();
    } catch (_) {}
    try {
      tempSourceFile.deleteSync();
    } catch (_) {}

    if (result.exitCode != 0) {
      final errOut = result.stderr.toString().trim();
      if (errOut.isNotEmpty) stderr.writeln(errOut);
      exit(result.exitCode);
    }

    // ── 5. Parse and write JSON output ────────────────────────────────────────
    final rawJson = result.stdout.toString().trim();
    if (rawJson.isEmpty) {
      _err('No output received from runner.');
      exit(1);
    }

    late Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    } catch (e) {
      _err('Failed to parse JSON: $e\nRaw output: $rawJson');
      exit(1);
    }

    final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);

    final outputDir = Directory(
      p.join(Directory.current.path, 'exported_json'),
    );
    if (!outputDir.existsSync()) outputDir.createSync(recursive: true);

    // Use  <fileName>_<keyValue>.json  for partial/widget exports so each
    // sub-tree gets its own file.  When the key matches the file name (i.e.
    // the user is exporting the whole screen) keep the simpler <fileName>.json.
    final outputBasename =
        (keyValue == fileName) ? '$fileName.json' : '${fileName}_$keyValue.json';
    final outputFile = File(p.join(outputDir.path, outputBasename));
    outputFile.writeAsStringSync(prettyJson);

    // ── 6. Success banner ─────────────────────────────────────────────────────
    stdout.writeln('''
╔══════════════════════════════════════════════════════╗
║  ✓  Export successful!                               ║
╚══════════════════════════════════════════════════════╝
  Key      : "$keyValue"
  Source   : ${sourceFile.path}
  Output   : ${outputFile.path}
  Size     : ${prettyJson.length} characters
''');
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  /// Recursively searches `lib/` for a file named `<fileName>.dart`.
  File? _findSourceFile() {
    final libDir = Directory(p.join(Directory.current.path, 'lib'));
    if (!libDir.existsSync()) return null;

    for (final entity in libDir.listSync(recursive: true)) {
      if (entity is File && p.basename(entity.path) == '$fileName.dart') {
        return entity;
      }
    }
    return null;
  }

  /// Creates a temporary file in the same directory, substituting flutter imports
  /// with the SDUI DSL so it can compile in the Dart VM.
  File _createTempSource(File sourceFile) {
    String content = sourceFile.readAsStringSync();

    // Replace standard Flutter package imports with our DSL mock
    content = content.replaceAll(
      RegExp(
        r"import\s+['"
        "]package:flutter/(?:material|widgets|cupertino|foundation)\.dart['"
        "];",
      ),
      "import 'package:sdui_library/sdui_dsl.dart';",
    );

    final String tempPath = sourceFile.path.replaceAll(
      RegExp(r'\.dart$'),
      '.sdui_temp.dart',
    );
    final tempFile = File(tempPath);
    tempFile.writeAsStringSync(content);

    return tempFile;
  }

  /// Parses top-level variable names from the source file using regex.
  /// These are forced-referenced in the runner to trigger lazy initialisation.
  List<String> _parseTopLevelVarNames(File sourceFile) {
    final source = sourceFile.readAsStringSync();
    // Match: final <name> = ... or final <Type> <name> = ...
    // We look for "final" followed by optionally a type and then a valid Dart identifer before "="
    final pattern = RegExp(
      r'^(?:final|var|late\s+final)\s+(?:[A-Za-z_][A-Za-z0-9_<>?]*\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*=',
      multiLine: true,
    );
    final names = <String>{};
    for (final match in pattern.allMatches(source)) {
      final name = match.group(1);
      if (name != null && name != '_' && !name.startsWith('_')) {
        names.add(name);
      }
    }
    // Also grab wildcard discard patterns like: final _ = ...
    // For these we can't reference by name, so we skip them.
    // Instead we also check for any undescore patterns that ARE accessible.
    return names.toList();
  }

  /// Parses class names that extend StatelessWidget from the source file.
  /// These are instantiated and their build() methods called in the runner.
  List<String> _parseStatelessWidgets(File sourceFile) {
    final source = sourceFile.readAsStringSync();
    final pattern = RegExp(
      r'class\s+([A-Za-z0-9_]+)\s+extends\s+StatelessWidget',
      multiLine: true,
    );
    final names = <String>{};
    for (final match in pattern.allMatches(source)) {
      names.add(match.group(1)!);
    }
    return names.toList();
  }

  /// Writes the temporary runner script and returns the [File].
  File _writeRunner(File sourceFile) {
    final dartToolDir = Directory(p.join(Directory.current.path, '.dart_tool'));
    if (!dartToolDir.existsSync()) dartToolDir.createSync(recursive: true);

    final runnerFile = File(p.join(dartToolDir.path, 'sdui_runner.dart'));

    // Convert the source file path to a package-root-relative import URI.
    // We use a relative path from .dart_tool/ → project root → lib/...
    final relImport = p
        .relative(sourceFile.path, from: dartToolDir.path)
        .replaceAll(r'\', '/');

    // Parse the DSL source file for top-level var names so we can
    // force-reference them in the runner to trigger lazy initialisation.
    final varNames = _parseTopLevelVarNames(sourceFile);
    final widgetNames = _parseStatelessWidgets(sourceFile);

    final forceInitLines = StringBuffer();
    if (varNames.isEmpty && widgetNames.isEmpty) {
      forceInitLines.writeln(
        '  // (no named top-level vars or StatelessWidgets found)',
      );
    } else {
      if (varNames.isNotEmpty) {
        forceInitLines.writeln('  // Force init top-level variables:');
        for (final n in varNames) {
          forceInitLines.writeln('  // ignore: unnecessary_statements');
          forceInitLines.writeln('  _dsl.$n;');
        }
      }
      if (widgetNames.isNotEmpty) {
        forceInitLines.writeln('  // Force init StatelessWidgets:');
        for (final c in widgetNames) {
          forceInitLines.writeln('  _dsl.$c().build(const BuildContext());');
        }
      }
    }

    final script =
        '''
// AUTO-GENERATED — do not edit.
// Created by: dart run sdui export $fileName $keyValue

import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:sdui_library/sdui_dsl.dart';
// We import the user file with a prefix so we can explicitly reference its
// top-level variables, forcing Dart to run their lazy initialisers.
// ignore: depend_on_referenced_packages
import '$relImport' as _dsl;

void main() {
  // Force all top-level variables in the DSL file to initialise.
  // Dart evaluates top-level final variables lazily (only on first access),
  // so we must touch each one to trigger SduiNode constructors and registry.
$forceInitLines

  final node = SduiRegistry.get('$keyValue');
  if (node == null) {
    final available = SduiRegistry.keys;
    stderr.writeln('');
    stderr.writeln('  \u2717  Key "$keyValue" not found in $fileName.dart');
    if (available.isEmpty) {
      stderr.writeln('     No keys were registered. Make sure your DSL widgets');
      stderr.writeln('     use Key(...) and are defined as top-level final variables.');
      stderr.writeln('     Note: Variables named "_" cannot be referenced and are skipped.');
    } else {
      stderr.writeln('     Available keys: \$available');
    }
    stderr.writeln('');
    exit(1);
  }

  print(jsonEncode(node.toJson()));
}
''';

    runnerFile.writeAsStringSync(script);
    return runnerFile;
  }

  void _log(String msg) => stdout.writeln('  $msg');
  void _err(String msg) => stderr.writeln('\n  ✗  $msg\n');
}
