import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Card] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Card",
///   "properties": {
///     "elevation": 4,
///     "color": "#FFFFFF",
///     "shadowColor": "#000000",
///     "borderRadius": 16,
///     "margin": 8
///   },
///   "child": { ... }
/// }
/// ```
class CardBuilder {
  CardBuilder._();

  static Widget fromJson(Map<String, dynamic> json, Widget? child) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final elevation = toDouble(props['elevation']) ?? 2.0;
    final color =
        props['color'] != null ? parseColor(props['color']) : null;
    final shadowColor = props['shadowColor'] != null
        ? parseColor(props['shadowColor'])
        : null;
    final borderRadius = parseBorderRadius(props['borderRadius'] ?? 12);
    final margin = parseEdgeInsets(props['margin']);

    return Card(
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: child,
    );
  }
}
