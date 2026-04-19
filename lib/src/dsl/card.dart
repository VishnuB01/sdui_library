import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Card] widget.
///
/// ### Usage
/// ```dart
/// Card(
///   key: Key('my_card'),
///   elevation: 4,
///   borderRadius: 12,
///   child: Padding(
///     padding: 16,
///     child: Text('Card content'),
///   ),
/// )
/// ```
class Card extends SduiNode {
  final double? elevation;

  /// Border radius: a number (uniform) or a map with `tl` / `tr` / `bl` / `br`.
  final dynamic borderRadius;

  final SduiNode? child;

  Card({
    Key? key,
    this.elevation,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Card',
        'properties': {
          if (elevation != null) 'elevation': elevation,
          if (borderRadius != null) 'borderRadius': borderRadius,
        },
        if (child != null) 'child': child!.toJson(),
      };
}
