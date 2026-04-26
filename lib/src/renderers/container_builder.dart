import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Container] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Container",
///   "properties": {
///     "height": 100,
///     "width": 200,
///     "color": "#4ECDC4",
///     "padding": 16,
///     "margin": { "horizontal": 8, "vertical": 4 },
///     "borderRadius": 12,
///     "borderColor": "#000000",
///     "borderWidth": 1.5,
///     "alignment": "center",
///     "gradient": {
///       "type": "linear",
///       "colors": ["#FF6B6B", "#4ECDC4"],
///       "begin": "topLeft",
///       "end": "bottomRight"
///     }
///   },
///   "child": { ... }
/// }
/// ```
class ContainerBuilder {
  ContainerBuilder._();

  static Widget fromJson(Map<String, dynamic> json, Widget? child) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final height = toDouble(props['height']);
    final width = toDouble(props['width']);
    final color = props['color'] != null ? parseColor(props['color']) : null;
    final padding = parseEdgeInsets(props['padding']);
    final margin = parseEdgeInsets(props['margin']);
    final borderRadius = parseBorderRadius(props['borderRadius']);
    final borderColor = props['borderColor'];
    final borderWidth = toDouble(props['borderWidth']) ?? 1.0;
    final alignment = props['alignment'] != null
        ? parseAlignment(props['alignment'] as String?)
        : null;

    final gradient = _parseGradient(props['gradient'] as Map<String, dynamic>?);

    BoxDecoration? decoration;
    if (borderColor != null || props['borderRadius'] != null || gradient != null) {
      decoration = BoxDecoration(
        color: gradient != null ? null : color,
        gradient: gradient,
        borderRadius: borderRadius,
        border: borderColor != null
            ? Border.all(
                color: parseColor(borderColor),
                width: borderWidth,
              )
            : null,
      );
    }

    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: decoration,
      color: decoration == null ? color : null,
      child: child,
    );
  }

  static Gradient? _parseGradient(Map<String, dynamic>? gradientJson) {
    if (gradientJson == null) return null;
    final type = gradientJson['type'] as String? ?? 'linear';
    final colorList = (gradientJson['colors'] as List<dynamic>?)
            ?.map((c) => parseColor(c))
            .toList() ??
        [];
    if (colorList.length < 2) return null;

    if (type == 'radial') {
      return RadialGradient(colors: colorList);
    }
    return LinearGradient(
      colors: colorList,
      begin: parseAlignment(gradientJson['begin'] as String?),
      end: parseAlignment(gradientJson['end'] as String?),
    );
  }
}
