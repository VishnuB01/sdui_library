import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds a [ListView] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "ListView",
///   "properties": {
///     "padding": 16,
///     "shrinkWrap": true,
///     "scrollDirection": "vertical",
///     "physics": "never"
///   },
///   "children": [ ... ]
/// }
/// ```
class ListViewBuilder {
  ListViewBuilder._();

  static Widget fromJson(Map<String, dynamic> json, List<Widget> children) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final padding = parseEdgeInsets(props['padding']);
    final shrinkWrap = props['shrinkWrap'] as bool? ?? false;
    final physics = _parseScrollPhysics(props['physics'] as String?);
    final scrollDirection =
        _parseScrollDirection(props['scrollDirection'] as String?);

    return ListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      scrollDirection: scrollDirection,
      children: children,
    );
  }

  static ScrollPhysics? _parseScrollPhysics(String? value) {
    switch (value) {
      case 'never':
        return const NeverScrollableScrollPhysics();
      case 'bouncing':
        return const BouncingScrollPhysics();
      case 'clamping':
        return const ClampingScrollPhysics();
      case 'always':
        return const AlwaysScrollableScrollPhysics();
      default:
        return null;
    }
  }

  static Axis _parseScrollDirection(String? value) {
    return value == 'horizontal' ? Axis.horizontal : Axis.vertical;
  }
}
