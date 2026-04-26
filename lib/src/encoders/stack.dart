import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Stack] widget.
///
/// ### Usage
/// ```dart
/// Stack(
///   key: Key('my_stack'),
///   alignment: 'center',
///   children: [
///     Container(color: 'Colors.blue', height: 200, width: 200),
///     Text('Overlay text', color: 'Colors.white'),
///   ],
/// )
/// ```
///
/// Supported [alignment] values: `topLeft`, `topCenter`, `topRight`,
/// `centerLeft`, `center`, `centerRight`, `bottomLeft`, `bottomCenter`, `bottomRight`
class Stack extends SduiNode {
  /// Alignment of children that do not have a [Positioned] parent.
  final String? alignment;
  final List<SduiNode> children;

  Stack({
    Key? key,
    this.alignment,
    this.children = const [],
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Stack',
        'properties': {
          if (alignment != null) 'alignment': alignment,
        },
        'children': children.map((c) => c.toJson()).toList(),
      };
}
