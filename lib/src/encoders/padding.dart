import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Padding] widget.
///
/// ### Usage
/// ```dart
/// Padding(
///   key: Key('my_padding'),
///   padding: 16,                          // all sides
///   // or: padding: {'horizontal': 24, 'vertical': 12},
///   // or: padding: {'left': 8, 'right': 8, 'top': 4, 'bottom': 4},
///   child: Text('Padded text'),
/// )
/// ```
class Padding extends SduiNode {
  /// Padding value: a number (all sides) or a map with
  /// `all` / `horizontal` / `vertical` / `left` / `top` / `right` / `bottom`.
  final dynamic padding;
  final SduiNode? child;

  Padding({
    Key? key,
    required this.padding,
    this.child,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Padding',
        'properties': {
          'padding': padding,
        },
        if (child != null) 'child': child!.toJson(),
      };
}
