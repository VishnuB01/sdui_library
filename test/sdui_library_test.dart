import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sdui_library/sdui_library.dart';

void main() {
  group('SduiParser', () {
    testWidgets('builds a Text widget from JSON', (tester) async {
      final json = {
        'widget': 'Text',
        'properties': {'data': 'Hello SDUI', 'fontSize': 16.0},
      };
      final widget = SduiParser.buildWidget(json);
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(find.text('Hello SDUI'), findsOneWidget);
    });

    testWidgets('returns fallback for unknown widget type', (tester) async {
      final json = {'widget': 'UnknownWidget123'};
      final widget = SduiParser.buildWidget(json);
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(find.textContaining("Can't find a widget"), findsOneWidget);
    });

    testWidgets('builds a Column with Text children', (tester) async {
      final json = {
        'widget': 'Column',
        'children': [
          {
            'widget': 'Text',
            'properties': {'data': 'Line 1'},
          },
          {
            'widget': 'Text',
            'properties': {'data': 'Line 2'},
          },
        ],
      };
      final widget = SduiParser.buildWidget(json);
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });

    test('SduiAction.fromJson parses correctly', () {
      final action = SduiAction.fromJson({
        'type': 'navigate',
        'payload': {'route': '/home'},
      });
      expect(action, isNotNull);
      expect(action!.type, equals('navigate'));
      expect(action.payload['route'], equals('/home'));
    });

    test('SduiAction.fromJson returns null for null input', () {
      expect(SduiAction.fromJson(null), isNull);
    });

    test('parseColor parses hex correctly', () {
      final color = parseColor('#6C63FF');
      expect(color.a, equals(1.0));
    });

    test('WidgetRegistry.registerWidget allows custom widgets', () {
      SduiParser.registerWidget('TestCustom', (json) => const SizedBox());
      expect(WidgetRegistry.contains('TestCustom'), isTrue);
    });
  });
}
