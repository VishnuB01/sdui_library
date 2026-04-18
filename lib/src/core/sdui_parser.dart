import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/sdui_action.dart';
import '../widgets/button_builder.dart';
import '../widgets/card_builder.dart';
import '../widgets/center_builder.dart';
import '../widgets/column_builder.dart';
import '../widgets/container_builder.dart';
import '../widgets/icon_builder.dart';
import '../widgets/image_builder.dart';
import '../widgets/listview_builder.dart';
import '../widgets/padding_builder.dart';
import '../widgets/row_builder.dart';
import '../widgets/stack_builder.dart';
import '../widgets/text_builder.dart';
import 'widget_registry.dart';

/// The main SDUI parsing engine.
///
/// Converts a JSON [Map] into a Flutter [Widget] tree.
///
/// ### Basic usage
/// ```dart
/// final json = {
///   "widget": "Column",
///   "children": [
///     { "widget": "Text", "properties": { "data": "Hello!" } }
///   ]
/// };
///
/// Widget ui = SduiParser.buildWidget(json);
/// ```
///
/// ### With action handling
/// ```dart
/// Widget ui = SduiParser.buildWidget(
///   json,
///   onAction: (action) {
///     if (action.type == 'navigate') {
///       Navigator.pushNamed(context, action.payload['route']);
///     }
///   },
/// );
/// ```
///
/// ### Registering custom widgets
/// Call this once at app startup before any parsing:
/// ```dart
/// SduiParser.registerWidget('MyWidget', (json) => MyCustomWidget());
/// ```
class SduiParser {
  SduiParser._();

  static bool _initialized = false;

  /// Initialises all built-in widget builders in the registry.
  /// Called automatically on first use. Safe to call multiple times.
  static void _ensureInitialized() {
    if (_initialized) return;
    _initialized = true;

    // ─── Layout ───────────────────────────────────────────────────────────────
    WidgetRegistry.register('Column', (json) {
      final children = _buildChildren(
        json['children'] as List<dynamic>?,
        onAction: _currentActionHandler,
      );
      return ColumnBuilder.fromJson(json, children);
    });

    WidgetRegistry.register('Row', (json) {
      final children = _buildChildren(
        json['children'] as List<dynamic>?,
        onAction: _currentActionHandler,
      );
      return RowBuilder.fromJson(json, children);
    });

    WidgetRegistry.register('Stack', (json) {
      final children = _buildChildren(
        json['children'] as List<dynamic>?,
        onAction: _currentActionHandler,
      );
      return StackBuilder.fromJson(json, children);
    });

    WidgetRegistry.register('Center', (json) {
      final child = _buildChild(
        json['child'] as Map<String, dynamic>?,
        onAction: _currentActionHandler,
      );
      return CenterBuilder.fromJson(json, child);
    });

    WidgetRegistry.register('Padding', (json) {
      final child = _buildChild(
        json['child'] as Map<String, dynamic>?,
        onAction: _currentActionHandler,
      );
      return PaddingBuilder.fromJson(json, child);
    });

    // ─── Content ──────────────────────────────────────────────────────────────
    WidgetRegistry.register('Container', (json) {
      final child = _buildChild(
        json['child'] as Map<String, dynamic>?,
        onAction: _currentActionHandler,
      );
      return ContainerBuilder.fromJson(json, child);
    });

    WidgetRegistry.register('Card', (json) {
      final child = _buildChild(
        json['child'] as Map<String, dynamic>?,
        onAction: _currentActionHandler,
      );
      return CardBuilder.fromJson(json, child);
    });

    WidgetRegistry.register('Text', (json) => TextBuilder.fromJson(json));

    WidgetRegistry.register('Image', (json) => ImageBuilder.fromJson(json));

    WidgetRegistry.register('Icon', (json) => IconBuilder.fromJson(json));

    // ─── Scroll ───────────────────────────────────────────────────────────────
    WidgetRegistry.register('ListView', (json) {
      final children = _buildChildren(
        json['children'] as List<dynamic>?,
        onAction: _currentActionHandler,
      );
      return ListViewBuilder.fromJson(json, children);
    });

    // ─── Buttons ──────────────────────────────────────────────────────────────
    for (final buttonType in ['ElevatedButton', 'TextButton', 'OutlinedButton']) {
      WidgetRegistry.register(buttonType, (json) {
        final iconJson = json['icon'] as Map<String, dynamic>?;
        final iconWidget =
            iconJson != null ? IconBuilder.fromJson(iconJson) : null;
        return ButtonBuilder.fromJson(json, iconWidget, _currentActionHandler);
      });
    }
  }

  // Holds the action handler for the current build pass.
  static SduiActionHandler? _currentActionHandler;

  // ─── Public API ─────────────────────────────────────────────────────────────

  /// Builds a [Widget] from a JSON [Map].
  ///
  /// [json] must contain a `"widget"` key with the widget type name.
  /// [onAction] is called when a widget dispatches an [SduiAction].
  static Widget buildWidget(
    Map<String, dynamic> json, {
    SduiActionHandler? onAction,
  }) {
    _ensureInitialized();
    _currentActionHandler = onAction;
    return _parseWidget(json);
  }

  /// Registers a custom widget builder. Call once at app startup.
  ///
  /// ```dart
  /// SduiParser.registerWidget('MyBanner', (json) => MyBannerWidget(json));
  /// ```
  static void registerWidget(String type, WidgetBuilderFromJson builder) {
    _ensureInitialized();
    WidgetRegistry.register(type, builder);
  }

  // ─── Internal Helpers ───────────────────────────────────────────────────────

  /// Parses a single widget from a JSON map.
  static Widget _parseWidget(Map<String, dynamic> json) {
    final type = json['widget'] as String?;

    if (type == null || type.isEmpty) {
      if (kDebugMode) {
        debugPrint('[SduiParser] Missing "widget" key in JSON: $json');
      }
      return WidgetRegistry.fallback('(unknown)');
    }

    final builder = WidgetRegistry.get(type);
    if (builder == null) {
      if (kDebugMode) {
        debugPrint('[SduiParser] No builder found for widget type: "$type"');
      }
      return WidgetRegistry.fallback(type);
    }

    try {
      return builder(json);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('[SduiParser] Error building "$type": $e\n$stackTrace');
      }
      return WidgetRegistry.fallback(type);
    }
  }

  /// Resolves a single optional child widget.
  static Widget? _buildChild(
    Map<String, dynamic>? childJson, {
    SduiActionHandler? onAction,
  }) {
    if (childJson == null) return null;
    _currentActionHandler = onAction;
    return _parseWidget(childJson);
  }

  /// Resolves a list of children widgets.
  static List<Widget> _buildChildren(
    List<dynamic>? childrenJson, {
    SduiActionHandler? onAction,
  }) {
    if (childrenJson == null) return [];
    _currentActionHandler = onAction;
    return childrenJson
        .whereType<Map<String, dynamic>>()
        .map(_parseWidget)
        .toList();
  }
}
