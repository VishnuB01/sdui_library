import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL representation of an SDUI action (e.g. button tap handler).
///
/// This is the pure-Dart equivalent of the runtime `SduiAction` model.
/// It serialises to the same JSON shape the SDUI parser expects under
/// `"onTap"`, `"onPressed"`, etc.
///
/// ### Usage
/// ```dart
/// ElevatedButton(
///   label: 'Go Home',
///   onTap: SduiAction(
///     type: 'navigate',
///     payload: {'route': '/home'},
///   ),
/// )
/// ```
class SduiAction extends SduiNode {
  /// The action type identifier (e.g. `'navigate'`, `'log'`, `'custom'`).
  final String type;

  /// Arbitrary key-value payload passed to the action handler.
  final Map<String, dynamic> payload;

  SduiAction({Key? key, required this.type, this.payload = const {}})
    : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (payload.isNotEmpty) 'payload': payload,
  };
}
