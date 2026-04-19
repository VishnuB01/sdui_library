import 'sdui_key.dart';
import 'sdui_node.dart';

/// Alias to make DSL files feel more like Flutter.
typedef Widget = SduiNode;

/// A mock BuildContext for the DSL.
class BuildContext {
  const BuildContext();
}

/// A mock StatelessWidget that allows developers to define UI using familiar
/// Flutter paradigms instead of top-level variables.
///
/// ### Usage
/// ```dart
/// class MyComponent extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Container(
///       key: Key('my_component'),
///       color: 'Colors.blue',
///     );
///   }
/// }
/// ```
abstract class StatelessWidget extends SduiNode {
  StatelessWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  @override
  Map<String, dynamic> toJson() {
    return build(const BuildContext()).toJson();
  }
}
