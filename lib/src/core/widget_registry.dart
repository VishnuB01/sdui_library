import 'package:flutter/material.dart';

/// A function signature for widget builders driven by JSON.
typedef WidgetBuilderFromJson = Widget Function(
  Map<String, dynamic> json,
);

/// A global registry that maps widget type strings to their builder functions.
///
/// Built-in widgets are pre-registered by [SduiParser.init].
/// Users can extend the registry by calling [WidgetRegistry.register] at startup:
///
/// ```dart
/// WidgetRegistry.register('MyWidget', (json) => MyWidget(...));
/// ```
class WidgetRegistry {
  WidgetRegistry._();

  static final Map<String, WidgetBuilderFromJson> _registry = {};

  /// Registers a custom [builder] for the given widget [type].
  /// Overwrites any existing builder for that type.
  static void register(String type, WidgetBuilderFromJson builder) {
    _registry[type] = builder;
  }

  /// Retrieves the builder for the given [type], or null if not found.
  static WidgetBuilderFromJson? get(String type) => _registry[type];

  /// Returns true if a builder exists for [type].
  static bool contains(String type) => _registry.containsKey(type);

  /// Clears all registered widgets (useful in tests).
  static void clear() => _registry.clear();

  /// Returns a set of all currently registered widget type names.
  static Set<String> get registeredTypes => Set.unmodifiable(_registry.keys);

  /// The fallback widget shown when a widget type is not found in the registry.
  ///
  /// Displays a styled error container with the unknown type name so developers
  /// can immediately see which widget definition is missing.
  static Widget fallback(String unknownType) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        border: Border.all(color: const Color(0xFFE53935), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFE53935), size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              "Can't find a widget like \"$unknownType\" that you parsed from JSON.",
              style: const TextStyle(
                color: Color(0xFFB71C1C),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
