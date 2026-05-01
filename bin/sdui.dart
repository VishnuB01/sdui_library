import 'dart:io';
import 'src/add_widget_command.dart';
import 'src/export_command.dart';

/// SDUI CLI entry point.
///
/// ### Usage
///
/// Export a widget tagged with [Key('my_key')] from a DSL file:
/// ```bash
/// dart run sdui export <file_name> <key_value>
/// ```
///
/// ### Example
///
/// Given `lib/screens/home_screen.dart` containing:
/// ```dart
/// import 'package:sdui_library/sdui_dsl.dart';
///
/// final _ = Column(
///   key: Key('home_screen'),
///   children: [
///     Container(key: Key('hero'), height: 200, color: 'Colors.red'),
///   ],
/// );
/// ```
///
/// Run:
/// ```bash
/// dart run sdui export home_screen hero
/// ```
///
/// This creates `exported_json/home_screen.json` containing the JSON for
/// the `Container` tagged with `Key('hero')`.
void main(List<String> args) {
  if (args.isEmpty) {
    _printUsage();
    exit(0);
  }

  final command = args[0];

  switch (command) {
    case 'export':
      if (args.length < 3) {
        stderr.writeln('\n  ✗  Missing arguments for "export" command.\n');
        _printUsage();
        exit(1);
      }
      ExportCommand(fileName: args[1], keyValue: args[2]).run();

    case 'add-widget':
      if (args.length < 2) {
        stderr.writeln(
          '\n  ✗  Missing widget name for "add-widget" command.\n',
        );
        _printUsage();
        exit(1);
      }
      AddWidgetCommand(widgetName: args[1]).run();

    case '--help':
    case '-h':
      _printUsage();

    default:
      stderr.writeln('\n  ✗  Unknown command: "$command"\n');
      _printUsage();
      exit(1);
  }
}

void _printUsage() {
  stdout.writeln('''
╔══════════════════════════════════════════════════════╗
║              SDUI CLI — Widget Tooling               ║
╚══════════════════════════════════════════════════════╝

Commands:
  export        Export a DSL widget tree to JSON.
  add-widget    Scaffold a custom widget inside your project.

── export ───────────────────────────────────────────────

Usage:
  dart run sdui export <file_name> <key_value>

Arguments:
  file_name   Name of the DSL file (without .dart extension).
              Searched recursively under lib/.
  key_value   The value string inside Key('...') on the widget
              you want to export.

Output:
  exported_json/<file_name>.json

Examples:
  dart run sdui export home_screen home_screen
  dart run sdui export home_screen hero_box
  dart run sdui export product_card price_section

── add-widget ───────────────────────────────────────────

Usage:
  dart run sdui add-widget <WidgetName>

Arguments:
  WidgetName  PascalCase name of your custom widget.

Generates:
  lib/sdui_widgets/<snake_name>/<snake_name>_encoder.dart
  lib/sdui_widgets/<snake_name>/<snake_name>_builder.dart
  lib/sdui_widgets/sdui_custom_widgets.dart  (created or updated)

Examples:
  dart run sdui add-widget RatingStars
  dart run sdui add-widget ProfileCard
  dart run sdui add-widget AnimatedBanner
''');
}
