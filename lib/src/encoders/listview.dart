import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [ListView] widget.
///
/// ### Usage
/// ```dart
/// ListView(
///   key: Key('my_list'),
///   padding: 16,
///   shrinkWrap: true,
///   children: [
///     Text('Item 1'),
///     Text('Item 2'),
///   ],
/// )
/// ```
class ListView extends SduiNode {
  /// Padding around the list. A number (all sides) or a map.
  final dynamic padding;
  final bool? shrinkWrap;
  final List<SduiNode> children;

  ListView({
    Key? key,
    this.padding,
    this.shrinkWrap,
    this.children = const [],
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'ListView',
        'properties': {
          if (padding != null) 'padding': padding,
          if (shrinkWrap != null) 'shrinkWrap': shrinkWrap,
        },
        'children': children.map((c) => c.toJson()).toList(),
      };
}
