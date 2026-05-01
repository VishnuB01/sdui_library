import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Column] widget.
///
/// ### Usage
/// ```dart
/// Column(
///   key: Key('my_column'),
///   mainAxisAlignment: 'center',
///   crossAxisAlignment: 'start',
///   children: [
///     Text('Hello'),
///     Text('World'),
///   ],
/// )
/// ```
///
/// Supported [mainAxisAlignment] values:
/// `start`, `end`, `center`, `spaceBetween`, `spaceAround`, `spaceEvenly`
///
/// Supported [crossAxisAlignment] values:
/// `start`, `end`, `center`, `stretch`, `baseline`
///
/// Supported [mainAxisSize] values: `max`, `min`
class Column extends SduiNode {
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;
  final String? mainAxisSize;
  final List<SduiNode> children;

  Column({
    Key? key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.children = const [],
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
    'widget': 'Column',
    'properties': {
      if (mainAxisAlignment != null) 'mainAxisAlignment': mainAxisAlignment,
      if (crossAxisAlignment != null) 'crossAxisAlignment': crossAxisAlignment,
      if (mainAxisSize != null) 'mainAxisSize': mainAxisSize,
    },
    'children': children.map((c) => c.toJson()).toList(),
  };
}
