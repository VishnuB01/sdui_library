import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Text] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Text",
///   "properties": {
///     "data": "Hello, World!",
///     "fontSize": 18,
///     "color": "#FF6B6B",
///     "fontWeight": "bold",
///     "textAlign": "center",
///     "maxLines": 2,
///     "overflow": "ellipsis",
///     "letterSpacing": 1.2,
///     "height": 1.5
///   }
/// }
/// ```
class TextBuilder {
  TextBuilder._();

  static Widget fromJson(Map<String, dynamic> json) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};
    final data = (props['data'] as String?) ?? '';

    final colorValue = props['color'];
    final fontSize = toDouble(props['fontSize']);
    final fontWeight = parseFontWeight(props['fontWeight'] as String?);
    final textAlign = parseTextAlign(props['textAlign'] as String?);
    final maxLines = props['maxLines'] as int?;
    final overflow = parseTextOverflow(props['overflow'] as String?);
    final letterSpacing = toDouble(props['letterSpacing']);
    final lineHeight = toDouble(props['height']);
    final fontFamily = props['fontFamily'] as String?;
    final decoration = _parseTextDecoration(props['decoration'] as String?);
    final textDecorationColor = props['decorationColor'] != null
        ? parseColor(props['decorationColor'])
        : null;

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow : null,
      style: TextStyle(
        fontSize: fontSize,
        color: parseColor(colorValue),
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: lineHeight,
        fontFamily: fontFamily,
        decoration: decoration,
        decorationColor: textDecorationColor,
      ),
    );
  }

  static TextDecoration? _parseTextDecoration(String? value) {
    switch (value) {
      case 'underline':
        return TextDecoration.underline;
      case 'lineThrough':
        return TextDecoration.lineThrough;
      case 'overline':
        return TextDecoration.overline;
      case 'none':
        return TextDecoration.none;
      default:
        return null;
    }
  }
}
