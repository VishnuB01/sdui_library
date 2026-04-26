import 'package:flutter/material.dart' as flutter;

/// Runtime renderer for `SizedBox` widgets.
///
/// Reads a JSON map that was produced by the [SizedBox] encoder (in `encoders/`)
/// and returns a real Flutter [flutter.SizedBox].
///
/// ### JSON shape expected
/// ```json
/// {
///   "widget": "SizedBox",
///   "properties": {
///     "width": 200,
///     "height": 120
///   },
///   "child": { "widget": "Text", "properties": { "data": "Hello" } }
/// }
/// ```
///
/// ### Example usage (inside SduiParser registration)
/// ```dart
/// // Register once at startup (already done in SduiParser._ensureInitialized)
/// WidgetRegistry.register('SizedBox', (json) {
///   final childJson = json['child'] as Map<String, dynamic>?;
///   final child = childJson != null ? SduiParser.buildWidget(childJson) : null;
///   return SizedBoxBuilder.fromJson(json, child);
/// });
///
/// // Then just parse normally anywhere in the app:
/// final Widget ui = SduiParser.buildWidget({
///   'widget': 'SizedBox',
///   'properties': {'width': 200, 'height': 120},
///   'child': {'widget': 'Text', 'properties': {'data': 'Hello SDUI'}},
/// });
/// ```
class SizedBoxBuilder {
  SizedBoxBuilder._();

  static flutter.Widget fromJson(
    Map<String, dynamic> json,
    flutter.Widget? child,
  ) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final width = (props['width'] as num?)?.toDouble();
    final height = (props['height'] as num?)?.toDouble();

    return flutter.SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
