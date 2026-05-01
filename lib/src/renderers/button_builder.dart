import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';
import '../models/sdui_action.dart';

/// Builds button widgets from a JSON definition.
/// Supports [ElevatedButton], [TextButton], and [OutlinedButton].
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "ElevatedButton",
///   "properties": {
///     "label": "Click Me",
///     "labelColor": "#FFFFFF",
///     "backgroundColor": "#6C63FF",
///     "borderRadius": 12,
///     "fontSize": 16,
///     "fontWeight": "bold",
///     "padding": { "horizontal": 24, "vertical": 14 }
///   },
///   "icon": { "widget": "Icon", "properties": { "icon": "star" } },
///   "onTap": {
///     "type": "navigate",
///     "payload": { "route": "/home" }
///   }
/// }
/// ```
class ButtonBuilder {
  ButtonBuilder._();

  static Widget fromJson(
    Map<String, dynamic> json,
    Widget? iconWidget,
    SduiActionHandler? onAction,
  ) {
    final type = json['widget'] as String? ?? 'ElevatedButton';
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final label = props['label'] as String? ?? '';
    final labelColor = props['labelColor'] != null
        ? parseColor(props['labelColor'])
        : null;
    final backgroundColor = props['backgroundColor'] != null
        ? parseColor(props['backgroundColor'])
        : null;
    final borderRadius = parseBorderRadius(props['borderRadius'] ?? 8);
    final fontSize = toDouble(props['fontSize']);
    final fontWeight = parseFontWeight(props['fontWeight'] as String?);
    final padding = props['padding'] != null
        ? parseEdgeInsets(props['padding'])
        : null;

    final action = SduiAction.fromJson(json['onTap']);

    void handleTap() {
      if (action != null && onAction != null) {
        onAction(action);
      }
    }

    final labelWidget = Text(
      label,
      style: TextStyle(
        color: labelColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );

    final shape = RoundedRectangleBorder(borderRadius: borderRadius);

    switch (type) {
      case 'TextButton':
        return TextButton(
          onPressed: handleTap,
          style: TextButton.styleFrom(
            foregroundColor: labelColor,
            padding: padding,
            shape: shape,
          ),
          child: iconWidget != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [iconWidget, const SizedBox(width: 8), labelWidget],
                )
              : labelWidget,
        );

      case 'OutlinedButton':
        final borderColor = props['borderColor'] != null
            ? parseColor(props['borderColor'])
            : null;
        return OutlinedButton(
          onPressed: handleTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: labelColor,
            padding: padding,
            shape: shape,
            side: borderColor != null
                ? BorderSide(
                    color: borderColor,
                    width: toDouble(props['borderWidth']) ?? 1.5,
                  )
                : null,
          ),
          child: iconWidget != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [iconWidget, const SizedBox(width: 8), labelWidget],
                )
              : labelWidget,
        );

      case 'ElevatedButton':
      default:
        return ElevatedButton(
          onPressed: handleTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: labelColor,
            padding: padding,
            shape: shape,
          ),
          child: iconWidget != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [iconWidget, const SizedBox(width: 8), labelWidget],
                )
              : labelWidget,
        );
    }
  }
}
