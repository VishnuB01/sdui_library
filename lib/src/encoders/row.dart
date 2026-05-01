import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Row] widget.
///
/// ### Usage
/// ```dart
/// Row(
///   key: Key('my_row'),
///   mainAxisAlignment: 'spaceBetween',
///   children: [
///     Icon(icon: 'star', color: 'Colors.amber'),
///     Text('Label'),
///   ],
/// )
/// ```
///
/// Supported [mainAxisAlignment]: `start`, `end`, `center`,
/// `spaceBetween`, `spaceAround`, `spaceEvenly`
///
/// Supported [crossAxisAlignment]: `start`, `end`, `center`, `stretch`
///
/// Supported [mainAxisSize]: `max`, `min`
class Row extends SduiNode {
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;
  final String? mainAxisSize;
  final List<SduiNode> children;

  Row({
    Key? key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.children = const [],
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
    'widget': 'Row',
    'properties': {
      if (mainAxisAlignment != null) 'mainAxisAlignment': mainAxisAlignment,
      if (crossAxisAlignment != null) 'crossAxisAlignment': crossAxisAlignment,
      if (mainAxisSize != null) 'mainAxisSize': mainAxisSize,
    },
    'children': children.map((c) => c.toJson()).toList(),
  };
}
