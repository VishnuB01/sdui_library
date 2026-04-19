# SDUI CLI User Guide

This guide explains how to use the SDUI (Server-Driven UI) CLI tool to export Flutter-like widget definitions written in Dart into pure JSON format. This JSON can then be served from your backend to render UI dynamically in your Flutter app using the `sdui_library`.

---

## 1. Creating a DSL Definitions File

Create standard `.dart` files anywhere under your `lib/` directory (for example, `lib/screens/home_screen.dart`). 

You can write standard Flutter code! We implemented a build-time interceptor so you can structure your layouts exactly as you already do in Flutter, getting full IDE support and hot-reload previews.

> **Important**: The CLI will automatically swap `package:flutter/material.dart` with our mock DSL package during export. Ensure you only use widgets supported by the SDUI parser and rely on `StatelessWidget`.

### Example: `lib/screens/home_screen.dart`

```dart
// You can use standard Flutter imports!
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('home_screen'), // Targeted by the CLI
      mainAxisAlignment: 'start',
      children: [
        Container(
          key: Key('hero_card'), // You can target nested keys too!
          height: 220,
          color: 'Colors.indigo', // Note: Colors are passed as strings
          borderRadius: {'tl': 0, 'tr': 0, 'bl': 32, 'br': 32},
          padding: {'horizontal': 24, 'vertical': 32},
          child: Column(
            mainAxisAlignment: 'center',
            crossAxisAlignment: 'start',
            children: [
              Text(
                'Welcome back 👋',
                fontSize: 14,
                color: 'Colors.white70',
                fontWeight: 'w400',
              ),
              Container(height: 8),
              Text(
                'Build. Export. Ship.',
                fontSize: 28,
                color: 'Colors.white',
                fontWeight: 'bold',
              ),
            ],
          ),
        ),
        Padding(
          padding: {'horizontal': 16, 'vertical': 20},
          child: ElevatedButton(
            label: 'Get Started',
            backgroundColor: 'Colors.indigo',
            labelColor: 'Colors.white',
            borderRadius: 12,
            onTap: SduiAction(
              type: 'navigate',
              payload: {'route': '/home'},
            ),
          ),
        ),
      ],
    );
  }
}
```

---

## 2. Using the Export Command

The CLI extracts a widget structure based on its `Key` value and outputs it directly into a new JSON file inside the `exported_json/` directory.

### Command Structure

```bash
dart run sdui_library:sdui export <file_name> <key_value>
```

- `<file_name>`: The name of your dart file containing the definitions (without '.dart'). The CLI automatically searches your `lib/` directory for this file.
- `<key_value>`: The string value you gave to your `Key('...')`.

*(Note: If you are actively modifying the `sdui_library` source code yourself, you should run `dart run bin/sdui.dart export <file_name> <key_value>` instead)*

### Example Execution

If we want to export the entire home screen:
```bash
dart run sdui_library:sdui export home_screen home_screen
```

Or, if we only wanted to export the specific hero card component, we target its unique key:
```bash
dart run sdui_library:sdui export home_screen hero_card
```

### CLI Output

When the command completes successfully, you will see output similar to this:

```text
  🔍  Searching for "home_screen.dart" under lib/ ...
     Found: D:\flutter projects\pub_packages\sdui_library\lib\screens\home_screen.dart
  📝  Generated runner at D:\flutter projects\pub_packages\sdui_library\.dart_tool\sdui_runner.dart
  ⚙️   Running export for key "home_screen" ...

╔══════════════════════════════════════════════════════╗
║  ✓  Export successful!                               ║
╚══════════════════════════════════════════════════════╝
  Key      : "home_screen"
  Source   : D:\flutter projects\pub_packages\sdui_library\lib\screens\home_screen.dart
  Output   : D:\flutter projects\pub_packages\sdui_library\exported_json\home_screen.json
  Size     : 14253 characters
```

---

## 3. The Generated Output

The tool will automatically create a cleanly-formatted JSON file ready to be served by your API.

**Example Output:** `exported_json/home_screen.json`
```json
{
  "widget": "Column",
  "properties": {
    "mainAxisAlignment": "start"
  },
  "children": [
    {
      "widget": "Container",
      "properties": {
        "height": 220,
        "color": "#3F51B5",
        "padding": {
          "horizontal": 24,
          "vertical": 32
        },
        "borderRadius": {
          "tl": 0,
          "tr": 0,
          "bl": 32,
          "br": 32
        }
      },
      "child": {
        "widget": "Column",
        "properties": {
          "mainAxisAlignment": "center",
          "crossAxisAlignment": "start"
        },
        "children": [
          {
            "widget": "Text",
            "properties": {
              "data": "Welcome back 👋",
              "fontSize": 14,
              "color": "#B3FFFFFF",
              "fontWeight": "w400"
            }
          },
          {
            "widget": "Container",
            "properties": {
              "height": 8
            }
          },
          {
            "widget": "Text",
            "properties": {
              "data": "Build. Export. Ship.",
              "fontSize": 28,
              "color": "#FFFFFF",
              "fontWeight": "bold"
            }
          }
        ]
      }
    },
    {
      "widget": "Padding",
      "properties": {
        "padding": {
          "horizontal": 16,
          "vertical": 20
        }
      },
      "child": {
        "widget": "ElevatedButton",
        "properties": {
          "label": "Get Started",
          "labelColor": "#FFFFFF",
          "backgroundColor": "#3F51B5",
          "borderRadius": 12
        },
        "onTap": {
          "type": "navigate",
          "payload": {
            "route": "/home"
          }
        }
      }
    }
  ]
}
```

This output utilizes the framework's native `Color` maps (converting `Colors.indigo` to `#3F51B5`) and cleanly exports custom `Actions` perfectly inline with the parent `sdui_library` structure.
