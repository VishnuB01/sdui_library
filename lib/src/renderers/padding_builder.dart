import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Padding] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Padding",
///   "properties": {
///     "padding": 16
///   },
///   "child": { ... }
/// }
/// ```
/// Or with directional padding:
/// ```json
/// {
///   "widget": "Padding",
///   "properties": {
///     "padding": { "left": 16, "top": 8, "right": 16, "bottom": 8 }
///   },
///   "child": { ... }
/// }
/// ```
class PaddingBuilder {
  PaddingBuilder._();

  static Widget fromJson(Map<String, dynamic> json, Widget? child) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};
    final padding = parseEdgeInsets(props['padding']);

    return Padding(
      padding: padding,
      child: child,
    );
  }
}
