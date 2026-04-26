import 'package:flutter/material.dart';

/// Builds a [Center] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Center",
///   "child": { ... }
/// }
/// ```
class CenterBuilder {
  CenterBuilder._();

  static Widget fromJson(Map<String, dynamic> json, Widget? child) {
    return Center(child: child);
  }
}
