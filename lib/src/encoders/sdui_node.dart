import 'sdui_key.dart';
import 'sdui_registry.dart';

/// Abstract base class for all SDUI DSL nodes.
///
/// Every DSL widget (Column, Container, Text, etc.) extends this class.
/// If a [Key] is provided in the constructor, the node self-registers
/// into [SduiRegistry] automatically so the CLI can look it up by name.
///
/// ### Implementing a custom node
/// ```dart
/// class MyWidget extends SduiNode {
///   final String label;
///   MyWidget({Key? key, required this.label}) : super(key: key);
///
///   @override
///   Map<String, dynamic> toJson() => {
///     'widget': 'MyWidget',
///     'properties': {'label': label},
///   };
/// }
/// ```
abstract class SduiNode {
  SduiNode({Key? key}) {
    if (key != null) {
      SduiRegistry.register(key, this);
    }
  }

  /// Serialises this node and all its children into the SDUI JSON format.
  Map<String, dynamic> toJson();
}
