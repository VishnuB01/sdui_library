/// SDUI Library — Server-Driven UI for Flutter
///
/// Build Flutter widgets dynamically from JSON at runtime using a
/// scalable Widget Registry (Factory Pattern).
///
/// ### Quick Start
/// ```dart
/// import 'package:sdui_library/sdui_library.dart';
///
/// final json = {
///   "widget": "Column",
///   "children": [
///     { "widget": "Text", "properties": { "data": "Hello, SDUI!" } }
///   ]
/// };
///
/// Widget ui = SduiParser.buildWidget(json);
/// ```
// ignore_for_file: dangling_library_doc_comments

export 'src/core/sdui_parser.dart';
export 'src/core/widget_registry.dart';
export 'src/core/sdui_utils.dart';
export 'src/models/sdui_action.dart';
