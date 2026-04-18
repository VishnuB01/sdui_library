import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [Column] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Column",
///   "properties": {
///     "mainAxisAlignment": "center",
///     "crossAxisAlignment": "start",
///     "mainAxisSize": "max"
///   },
///   "children": [ ... ]
/// }
/// ```
class ColumnBuilder {
  ColumnBuilder._();

  static Widget fromJson(Map<String, dynamic> json, List<Widget> children) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    return Column(
      mainAxisAlignment:
          parseMainAxisAlignment(props['mainAxisAlignment'] as String?),
      crossAxisAlignment:
          parseCrossAxisAlignment(props['crossAxisAlignment'] as String?),
      mainAxisSize: parseMainAxisSize(props['mainAxisSize'] as String?),
      children: children,
    );
  }
}
