/// SDUI DSL — Server-Driven UI Widget Builder
///
/// Import this library in your DSL definition files to compose widget trees
/// using Flutter-like syntax. The result can be exported to JSON via the
/// SDUI CLI tool.
///
/// > **Important**: Do NOT import this library in the same file as
/// > `package:flutter/material.dart`. Class names (`Column`, `Container`,
/// > `Text`, etc.) conflict. Keep DSL definition files Flutter-free.
///
/// ### Quick start
/// ```dart
/// import 'package:sdui_library/sdui_dsl.dart';
///
/// final _ = Column(
///   key: Key('home_screen'),
///   mainAxisAlignment: 'center',
///   children: [
///     Container(
///       key: Key('hero'),
///       height: 200,
///       color: 'Colors.indigo',
///       borderRadius: 16,
///       child: Text('Welcome', fontSize: 32, color: 'Colors.white'),
///     ),
///     ElevatedButton(
///       label: 'Get Started',
///       backgroundColor: 'Colors.indigo',
///       onTap: SduiAction(type: 'navigate', payload: {'route': '/home'}),
///     ),
///   ],
/// );
/// ```
///
/// ### Export via CLI
/// ```bash
/// dart run sdui export home_screen home_screen
/// dart run sdui export home_screen hero
/// ```
library sdui_dsl;

// Foundation
export 'src/encoders/sdui_key.dart';
export 'src/encoders/sdui_registry.dart';
export 'src/encoders/sdui_node.dart';
export 'src/encoders/sdui_action.dart';
export 'src/encoders/color_resolver.dart';
export 'src/encoders/stateless_widget.dart';

// Layout
export 'src/encoders/column.dart';
export 'src/encoders/row.dart';
export 'src/encoders/stack.dart';
export 'src/encoders/center.dart';
export 'src/encoders/padding.dart';

// Content
export 'src/encoders/container.dart';
export 'src/encoders/card.dart';
export 'src/encoders/text.dart';
export 'src/encoders/image.dart';
export 'src/encoders/icon.dart';

// Scroll
export 'src/encoders/listview.dart';

// Interactive
export 'src/encoders/button.dart';
