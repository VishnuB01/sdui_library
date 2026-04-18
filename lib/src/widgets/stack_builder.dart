import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Stack] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Stack",
///   "properties": {
///     "alignment": "center",
///     "fit": "loose"
///   },
///   "children": [ ... ]
/// }
/// ```
class StackBuilder {
  StackBuilder._();

  static Widget fromJson(Map<String, dynamic> json, List<Widget> children) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final alignment = parseAlignment(props['alignment'] as String?);
    final fit = _parseStackFit(props['fit'] as String?);

    return Stack(
      alignment: alignment,
      fit: fit,
      children: children,
    );
  }

  static StackFit _parseStackFit(String? value) {
    switch (value) {
      case 'expand':
        return StackFit.expand;
      case 'passthrough':
        return StackFit.passthrough;
      case 'loose':
      default:
        return StackFit.loose;
    }
  }
}
