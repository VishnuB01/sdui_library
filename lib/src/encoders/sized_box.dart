import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL encoder for a [SizedBox]-like spacer/size-constraint widget.
///
/// Use this in your SDUI definition files to describe a SizedBox.
/// The [toJson] output is what gets persisted / sent over the wire.
///
/// ### Example (definition file — no Flutter import needed)
/// ```dart
/// import 'package:sdui_library/sdui_dsl.dart';
///
/// // Fixed-size box wrapping a child
/// final card = SizedBox(
///   key: Key('hero_spacer'),
///   width: 200,
///   height: 120,
///   child: Text('Hello', fontSize: 18),
/// );
///
/// // Pure vertical spacer (no child)
/// final gap = SizedBox(height: 24);
/// ```
class SizedBox extends SduiNode {
  final double? width;
  final double? height;
  final SduiNode? child;

  SizedBox({Key? key, this.width, this.height, this.child}) : super(key: key);

  @override
  Map<String, dynamic> toJson() {
    return {
      'widget': 'SizedBox',
      'properties': {
        if (width != null) 'width': width,
        if (height != null) 'height': height,
      },
      if (child != null) 'child': child!.toJson(),
    };
  }
}
