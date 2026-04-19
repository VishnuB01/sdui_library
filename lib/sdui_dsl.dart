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
export 'src/dsl/sdui_key.dart';
export 'src/dsl/sdui_registry.dart';
export 'src/dsl/sdui_node.dart';
export 'src/dsl/sdui_action.dart';
export 'src/dsl/color_resolver.dart';
export 'src/dsl/stateless_widget.dart';

// Layout
export 'src/dsl/column.dart';
export 'src/dsl/row.dart';
export 'src/dsl/stack.dart';
export 'src/dsl/center.dart';
export 'src/dsl/padding.dart';

// Content
export 'src/dsl/container.dart';
export 'src/dsl/card.dart';
export 'src/dsl/text.dart';
export 'src/dsl/image.dart';
export 'src/dsl/icon.dart';

// Scroll
export 'src/dsl/listview.dart';

// Interactive
export 'src/dsl/button.dart';
