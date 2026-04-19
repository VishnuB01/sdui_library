import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for an [Icon] widget.
///
/// ### Usage
/// ```dart
/// Icon(
///   icon: 'star',
///   key: Key('my_icon'),
///   color: 'Colors.amber',
///   size: 32,
/// )
/// ```
///
/// Supported icon names include: `home`, `back`, `forward`, `menu`, `close`,
/// `search`, `settings`, `add`, `edit`, `delete`, `share`, `star`,
/// `favorite`, `person`, `location`, `calendar`, `cart`, `payment`,
/// and many more. See `icon_builder.dart` for the full list.
class Icon extends SduiNode {
  /// Icon name string (e.g. `'star'`, `'home'`, `'edit'`).
  final String icon;
  final String? color;
  final double? size;

  Icon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Icon',
        'properties': {
          'icon': icon,
          if (color != null) 'color': color,
          if (size != null) 'size': size,
        },
      };
}
