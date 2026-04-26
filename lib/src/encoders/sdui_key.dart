/// A lightweight key class used to identify and export specific DSL nodes.
///
/// This mirrors Flutter's [Key] semantics but has no Flutter dependency,
/// allowing DSL files to remain pure Dart.
///
/// ### Usage
/// ```dart
/// Container(
///   key: Key('my_container'),
///   height: 100,
///   color: 'Colors.red',
/// )
/// ```
///
/// Then export via CLI:
/// ```bash
/// dart run sdui export home_screen my_container
/// ```
class Key {
  /// The string identifier for this key.
  final String value;

  const Key(this.value);

  @override
  String toString() => "Key('$value')";

  @override
  bool operator ==(Object other) => other is Key && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
