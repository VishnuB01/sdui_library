import 'color_resolver.dart';
import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Container] widget.
///
/// ### Usage
/// ```dart
/// Container(
///   key: Key('hero_box'),
///   height: 200,
///   width: double.infinity,
///   color: 'Colors.red',        // Flutter color name
///   // or: color: '#FF6B6B',    // hex string
///   padding: 16,                // uniform padding
///   // or: padding: {'horizontal': 24, 'vertical': 12},
///   margin: {'top': 8, 'bottom': 8},
///   borderRadius: 12,           // uniform radius
///   // or: borderRadius: {'tl': 16, 'tr': 16, 'bl': 0, 'br': 0},
///   borderColor: 'Colors.grey.shade300',
///   borderWidth: 1.5,
///   alignment: 'center',
///   gradient: {
///     'type': 'linear',
///     'colors': ['#FF6B6B', '#4ECDC4'],
///     'begin': 'topLeft',
///     'end': 'bottomRight',
///   },
///   child: Text('Hello'),
/// )
/// ```
class Container extends SduiNode {
  final double? height;
  final double? width;

  /// Color string: `'Colors.red'` or `'#FF0000'`.
  final String? color;

  /// Padding: a number (all sides) or a map with
  /// `all` / `horizontal` / `vertical` / `left` / `top` / `right` / `bottom`.
  final dynamic padding;

  /// Margin: same format as [padding].
  final dynamic margin;

  /// Border radius: a number (uniform) or a map with `tl` / `tr` / `bl` / `br`.
  final dynamic borderRadius;

  /// Border color string: `'Colors.grey'` or `'#CCCCCC'`.
  final String? borderColor;

  final double? borderWidth;

  /// Alignment: `'center'`, `'topLeft'`, `'bottomRight'`, etc.
  final String? alignment;

  /// Gradient map: `{'type': 'linear', 'colors': [...], 'begin': ..., 'end': ...}`.
  final Map<String, dynamic>? gradient;

  final SduiNode? child;

  Container({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.alignment,
    this.gradient,
    this.child,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Container',
        'properties': {
          if (height != null) 'height': height,
          if (width != null) 'width': width,
          if (color != null) 'color': resolveColor(color),
          if (padding != null) 'padding': padding,
          if (margin != null) 'margin': margin,
          if (borderRadius != null) 'borderRadius': borderRadius,
          if (borderColor != null) 'borderColor': resolveColor(borderColor),
          if (borderWidth != null) 'borderWidth': borderWidth,
          if (alignment != null) 'alignment': alignment,
          if (gradient != null) 'gradient': gradient,
        },
        if (child != null) 'child': child!.toJson(),
      };
}
