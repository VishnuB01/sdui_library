import 'sdui_key.dart';
import 'sdui_node.dart';

/// A global registry that maps [Key] values to [SduiNode] instances.
///
/// Nodes automatically register themselves during construction when a [Key]
/// is provided. The CLI runner uses this to look up a node by key string
/// and call [SduiNode.toJson] on it.
///
/// ### How it works
/// 1. Developer tags a DSL widget with `key: Key('my_widget')`.
/// 2. When the DSL file is imported, top-level `final` variables
///    initialize, calling the constructor and registering the node here.
/// 3. The CLI runner calls [SduiRegistry.get('my_widget')] to retrieve it.
class SduiRegistry {
  SduiRegistry._();

  static final Map<String, SduiNode> _map = {};

  /// Registers [node] under the given [key].
  /// Called automatically by [SduiNode] when a [Key] is supplied.
  static void register(Key key, SduiNode node) {
    _map[key.value] = node;
  }

  /// Returns the [SduiNode] registered under [keyValue], or null if not found.
  static SduiNode? get(String keyValue) => _map[keyValue];

  /// Returns all currently registered key strings.
  /// Useful for error messages when a key is not found.
  static List<String> get keys => List.unmodifiable(_map.keys);

  /// Clears the registry (useful in tests).
  static void clear() => _map.clear();
}
