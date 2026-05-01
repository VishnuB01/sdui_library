/// Represents an action dispatched from an SDUI widget (e.g. button tap).
///
/// The library is side-effect free — actions are decoded from JSON and
/// passed to the user-supplied [SduiActionHandler] for handling.
///
/// Example JSON:
/// ```json
/// {
///   "onTap": {
///     "type": "navigate",
///     "payload": { "route": "/detail", "id": 42 }
///   }
/// }
/// ```
class SduiAction {
  /// The action type identifier (e.g. "navigate", "log", "custom").
  final String type;

  /// Arbitrary key-value payload for the action.
  final Map<String, dynamic> payload;

  const SduiAction({required this.type, this.payload = const {}});

  /// Parses an [SduiAction] from a JSON map.
  /// Returns null if the input is null or malformed.
  static SduiAction? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is! Map<String, dynamic>) return null;
    final type = json['type'];
    if (type == null || type is! String) return null;
    return SduiAction(
      type: type,
      payload: (json['payload'] as Map<String, dynamic>?) ?? {},
    );
  }

  @override
  String toString() => 'SduiAction(type: $type, payload: $payload)';
}

/// A callback type for handling SDUI actions.
typedef SduiActionHandler = void Function(SduiAction action);
