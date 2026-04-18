import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Row] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Row",
///   "properties": {
///     "mainAxisAlignment": "spaceBetween",
///     "crossAxisAlignment": "center",
///     "mainAxisSize": "max"
///   },
///   "children": [ ... ]
/// }
/// ```
class RowBuilder {
  RowBuilder._();

  static Widget fromJson(Map<String, dynamic> json, List<Widget> children) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    return Row(
      mainAxisAlignment:
          parseMainAxisAlignment(props['mainAxisAlignment'] as String?),
      crossAxisAlignment:
          parseCrossAxisAlignment(props['crossAxisAlignment'] as String?),
      mainAxisSize: parseMainAxisSize(props['mainAxisSize'] as String?),
      children: children,
    );
  }
}
