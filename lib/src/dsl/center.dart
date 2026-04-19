import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Center] widget.
///
/// ### Usage
/// ```dart
/// Center(
///   key: Key('my_center'),
///   child: Text('Centered text'),
/// )
/// ```
class Center extends SduiNode {
  final SduiNode? child;

  Center({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Center',
        'properties': const {},
        if (child != null) 'child': child!.toJson(),
      };
}
