# SDUI Library (Server-Driven UI for Flutter)

A powerful, highly scalable Server-Driven UI framework for Flutter. It allows you to dynamically render native Flutter widgets entirely from JSON served from your backend. Best of all, it includes a robust command-line interface (CLI) to automatically export standard Flutter widget trees directly into deployable SDUI JSON.

## Features

- **Dynamic Rendering**: Build complex UIs at runtime without deploying app updates.
- **Scalable Registry Pattern**: Easily register your own custom widgets via `SduiParser.registerWidget`.
- **Action Handling**: Intercept and process UI interactions seamlessly via `SduiAction`.
- **CLI Exporter**: Build your Server-Driven UI payloads using real Flutter Code and export them instantly to JSON using `dart run`.
- **Extensive Built-in Widgets**: Supports `Column`, `Row`, `Container`, `Card`, `Text`, `ListView`, `ElevatedButton`, and more!

---

## 1. Using the JSON Parser (App Side)

To render a Server-Driven UI in your Flutter app, you simply pass the received JSON Map to `SduiParser.buildWidget()`.

### Example

```dart
import 'package:flutter/material.dart';
import 'package:sdui_library/sdui_library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Map<String, dynamic> myJsonPayload = const {
    "widget": "Column",
    "properties": { "mainAxisAlignment": "center" },
    "children": [
      {
        "widget": "Container",
        "properties": {
          "color": "#6C63FF",
          "padding": 24,
          "borderRadius": 12
        },
        "child": {
          "widget": "Text",
          "properties": {
            "data": "Hello SDUI!",
            "color": "#FFFFFF",
            "fontSize": 24,
            "fontWeight": "bold"
          }
        }
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SduiParser.buildWidget(
            myJsonPayload, 
            onAction: (action) {
              print('Action intercepted: ${action.type}');
              print('Payload: ${action.payload}');
            }
          ),
        ),
      ),
    );
  }
}
```

---

## 2. Using the Export CLI

You don't need to write the JSON schemas by hand. Instead, you can write UI components using standard Flutter code (getting full IDE support, auto-complete, and Hot Reload previews!) and generate the JSON using the CLI.

### Creating the Flutter Component
Create a standard `.dart` file under your `lib/` directory.

> **Important**: The CLI will automatically intercept `package:flutter/material.dart` during the export phase, mapping it safely to our mock DSL. Just ensure you use `StatelessWidget` and assign a unique `Key('...')` to the widget you want to export.

```dart
// lib/screens/welcome_card.dart
import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('hero_section'), // The CLI targets this key!
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: Column(
        children: [
          Text('Welcome Back', fontSize: 22, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
```

### Running the CLI
To export the `Container` tagged with `Key('hero_section')`, run the following command in your terminal:

```bash
dart run sdui_library:sdui export welcome_card hero_section
```

### Output
A generated json file will correctly appear in `exported_json/welcome_card.json` containing the properly formatted SDUI schema equivalent!

---

## 3. Registering Custom Widgets

While `sdui_library` supports many foundational elements natively, you can easily register your custom, complex, or proprietary widgets so the parser understands them.

```dart
// 1. Register it once (e.g., in your main() function)
SduiParser.registerWidget('MyCustomBadge', (json) {
  final props = (json['properties'] as Map<String, dynamic>?) ?? {};
  final label = props['label'] as String? ?? 'N/A';
  final color = parseColor(props['color']) ?? Colors.grey;

  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
});
```

Now, your backend simply serves:
```json
{
  "widget": "MyCustomBadge",
  "properties": {
    "label": "Super User",
    "color": "#FFC107"
  }
}
```
