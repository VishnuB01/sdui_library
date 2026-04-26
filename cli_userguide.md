# SDUI CLI User Guide

The SDUI CLI is a developer tool bundled with `sdui_library` that lets you:

1. **Export** — Serialize Flutter-like widget trees defined in Dart into SDUI-compatible JSON, ready to be served from your backend.
2. **Scaffold** — Generate boilerplate for custom widgets that don't exist in the library, so they can be exported to JSON and rendered back from JSON in your app.

---

## Table of Contents

1. [Running the CLI](#running-the-cli)
2. [Command: `export`](#command-export)
3. [Command: `add-widget`](#command-add-widget)
4. [Working with Custom Widgets — end-to-end](#working-with-custom-widgets--end-to-end)
5. [Tips & Rules of Thumb](#tips--rules-of-thumb)

---

## Running the CLI

The command differs depending on **where** you run it from:

| Context | Command prefix |
|---|---|
| Inside the `sdui_library` package itself | `dart run sdui` |
| Inside **your own Flutter project** (recommended) | `dart run sdui_library:sdui` |

> All examples in this guide use `dart run sdui_library:sdui`, which is the normal usage when `sdui_library` is a dependency in your `pubspec.yaml`.

### See all available commands

```bash
dart run sdui_library:sdui --help
```

```
╔══════════════════════════════════════════════════════╗
║              SDUI CLI — Widget Tooling               ║
╚══════════════════════════════════════════════════════╝

Commands:
  export        Export a DSL widget tree to JSON.
  add-widget    Scaffold a custom widget inside your project.

── export ───────────────────────────────────────────────

Usage:
  dart run sdui_library:sdui export <file_name> <key_value>
...

── add-widget ───────────────────────────────────────────

Usage:
  dart run sdui_library:sdui add-widget <WidgetName>
...
```

---

## Command: `export`

Finds a DSL file in your `lib/` folder, evaluates it, and serializes the widget tagged with the given `Key(...)` to a pretty-printed JSON file.

### Syntax

```bash
dart run sdui_library:sdui export <file_name> <key_value>
```

| Argument | Description |
|---|---|
| `file_name` | Name of your Dart DSL file, **without** the `.dart` extension. The CLI searches recursively under `lib/`. |
| `key_value` | The string you passed to `Key('...')` on the widget you want to export. |

**Output:** `exported_json/<file_name>.json`

---

### Step 1 — Write a DSL file under `lib/`

Create a Dart file anywhere inside your `lib/` directory. You can use either:
- `package:sdui_library/sdui_dsl.dart` (recommended — pure Dart, Flutter-free)
- Standard `package:flutter/material.dart` imports (the CLI swaps these automatically)

> **Important:** Top-level variables must have a real name (not `_`). The CLI references them by name to force lazy initialisation. Variables named `_` are skipped.

**✓ Correct:**
```dart
// lib/screens/home_screen.dart
import 'package:sdui_library/sdui_dsl.dart';

final homeScreen = Column(   // ← named variable, CLI can touch it
  key: Key('home_screen'),
  children: [
    Container(
      key: Key('hero_card'),
      height: 220,
      color: 'Colors.indigo',
      child: Text('Welcome back 👋', fontSize: 28, color: 'Colors.white'),
    ),
  ],
);
```

**✗ Wrong — CLI will skip this:**
```dart
final _ = Column(key: Key('home_screen'), ...);  // ← _ is not referenceable
```

---

### Step 2 — Run the export

Export the **full screen** (widget tagged `Key('home_screen')`):
```bash
dart run sdui_library:sdui export home_screen home_screen
```

Export just the **hero card** subtree (widget tagged `Key('hero_card')`):
```bash
dart run sdui_library:sdui export home_screen hero_card
```

You can have **multiple `Key(...)` values** in the same file and export them individually. Each export overwrites `exported_json/<file_name>.json` with the chosen subtree.

---

### Step 3 — Inspect the output

```
╔══════════════════════════════════════════════════════╗
║  ✓  Export successful!                               ║
╚══════════════════════════════════════════════════════╝
  Key      : "home_screen"
  Source   : lib/screens/home_screen.dart
  Output   : exported_json/home_screen.json
  Size     : 1423 characters
```

**Example `exported_json/home_screen.json`:**
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
        "borderRadius": { "tl": 0, "tr": 0, "bl": 32, "br": 32 },
        "padding": { "horizontal": 24, "vertical": 32 }
      },
      "child": {
        "widget": "Text",
        "properties": {
          "data": "Welcome back 👋",
          "fontSize": 28,
          "color": "#FFFFFF",
          "fontWeight": "bold"
        }
      }
    }
  ]
}
```

> Colors are automatically resolved: `'Colors.indigo'` → `"#3F51B5"`, `'Colors.white70'` → `"#B3FFFFFF"`, etc.

---

## Command: `add-widget`

Scaffolds a custom widget inside **your** project when a widget type doesn't exist in the `sdui_library` built-ins (e.g. `RatingStars`, `ProfileCard`, `AnimatedBanner`).

### Syntax

```bash
dart run sdui_library:sdui add-widget <WidgetName>
```

| Argument | Description |
|---|---|
| `WidgetName` | PascalCase class name for your widget, e.g. `RatingStars`, `ProfileCard`. |

**Generates (inside your project's `lib/sdui_widgets/`):**

```
lib/
└── sdui_widgets/
    ├── sdui_custom_widgets.dart             ← barrel file (created or updated)
    └── <snake_name>/
        ├── <snake_name>_encoder.dart        ← DSL node (pure Dart, no Flutter)
        └── <snake_name>_builder.dart        ← Runtime builder (Flutter, JSON → Widget)
```

---

### Step 1 — Scaffold the widget

```bash
dart run sdui_library:sdui add-widget RatingStars
```

```
╔══════════════════════════════════════════════════════╗
║  ✓  Widget scaffolded successfully!                  ║
╚══════════════════════════════════════════════════════╝
  Widget   : RatingStars
  Location : lib/sdui_widgets/rating_stars/

  Generated files:
    lib/sdui_widgets/rating_stars/rating_stars_encoder.dart
    lib/sdui_widgets/rating_stars/rating_stars_builder.dart
    lib/sdui_widgets/sdui_custom_widgets.dart
```

Running it a **second time** for a different widget updates the barrel automatically:
```bash
dart run sdui_library:sdui add-widget ProfileCard
# → lib/sdui_widgets/sdui_custom_widgets.dart now registers both widgets
```

---

### Step 2 — Implement the encoder

Open `lib/sdui_widgets/rating_stars/rating_stars_encoder.dart`. Replace the placeholder `label` property with your real widget fields. This file must stay **Flutter-free** — it runs in a plain Dart VM.

```dart
// lib/sdui_widgets/rating_stars/rating_stars_encoder.dart
import 'package:sdui_library/sdui_dsl.dart';

class RatingStars extends SduiNode {
  final double rating;
  final int maxStars;
  final String? starColor;
  final double? size;

  RatingStars({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.starColor,
    this.size,
  });

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'RatingStars',
        'properties': {
          'rating': rating,
          'maxStars': maxStars,
          if (starColor != null) 'starColor': starColor,
          if (size != null) 'size': size,
        },
      };
}
```

---

### Step 3 — Implement the builder

Open `lib/sdui_widgets/rating_stars/rating_stars_builder.dart`. Replace the `Text(label)` placeholder with your real Flutter widget:

```dart
// lib/sdui_widgets/rating_stars/rating_stars_builder.dart
import 'package:flutter/material.dart';

class RatingStarsBuilder {
  RatingStarsBuilder._();

  static Widget fromJson(Map<String, dynamic> json) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};
    final rating = (props['rating'] as num?)?.toDouble() ?? 0.0;
    final maxStars = (props['maxStars'] as int?) ?? 5;
    final size = (props['size'] as num?)?.toDouble() ?? 22.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) => Icon(
        i < rating.floor() ? Icons.star_rounded : Icons.star_outline_rounded,
        color: const Color(0xFFF59E0B),
        size: size,
      )),
    );
  }
}
```

---

### Step 4 — Register at app startup

Import the barrel file once in `main.dart` and call `registerCustomWidgets()` before `runApp`:

```dart
// main.dart
import 'package:your_app/sdui_widgets/sdui_custom_widgets.dart';

void main() {
  registerCustomWidgets();   // ← registers all scaffolded widgets
  runApp(MyApp());
}
```

`sdui_custom_widgets.dart` is managed by the CLI — every new `add-widget` call appends to it automatically. You never need to edit it manually.

---

### Step 5 — Use in DSL files and export

```dart
// lib/screens/product_screen.dart
import 'package:sdui_library/sdui_dsl.dart';
import 'sdui_widgets/rating_stars/rating_stars_encoder.dart';

final productScreen = Column(
  key: Key('product_screen'),
  children: [
    Text('Pro Headphones', fontSize: 22, fontWeight: 'bold'),
    RatingStars(
      key: Key('product_rating'),  // ← can be exported independently
      rating: 4.5,
      maxStars: 5,
      starColor: '#F59E0B',
    ),
  ],
);
```

```bash
dart run sdui_library:sdui export product_screen product_screen
dart run sdui_library:sdui export product_screen product_rating
```

---

### Step 6 — Render from JSON at runtime

Once registered, `SduiParser` resolves `"widget": "RatingStars"` automatically:

```dart
final json = {
  "widget": "RatingStars",
  "properties": { "rating": 4.5, "maxStars": 5 }
};

Widget ui = SduiParser.buildWidget(json);
```

---

## Working with Custom Widgets — end-to-end

Here is the full journey for a `RatingStars` widget from zero to rendered:

```
1. dart run sdui_library:sdui add-widget RatingStars
         ↓
   lib/sdui_widgets/rating_stars/rating_stars_encoder.dart  (edit this)
   lib/sdui_widgets/rating_stars/rating_stars_builder.dart  (edit this)
   lib/sdui_widgets/sdui_custom_widgets.dart                (auto-managed)

2. Edit encoder  →  define real properties (pure Dart, no Flutter imports)
3. Edit builder  →  return a real Flutter Widget from the JSON properties

4. main.dart:
   import 'sdui_widgets/sdui_custom_widgets.dart';
   void main() { registerCustomWidgets(); runApp(MyApp()); }

5. lib/screens/product_screen.dart:
   import 'package:sdui_library/sdui_dsl.dart';
   import 'sdui_widgets/rating_stars/rating_stars_encoder.dart';
   final productScreen = Column(
     key: Key('product_screen'),
     children: [ RatingStars(key: Key('stars'), rating: 4.5) ],
   );

6. dart run sdui_library:sdui export product_screen stars
         ↓
   exported_json/product_screen.json

7. Serve JSON from your API → SduiParser.buildWidget(json) renders it ✓
```

---

## Tips & Rules of Thumb

| Rule | Why |
|---|---|
| DSL files must live under `lib/` | The CLI only searches recursively inside `lib/` |
| Top-level variables must be named (not `_`) | `_` is skipped — the CLI can't reference it to trigger lazy init |
| Encoder files must be Flutter-free | They run in a plain Dart VM, not a Flutter environment |
| Call `registerCustomWidgets()` before `runApp` | The registry must be populated before any JSON is parsed |
| Each `add-widget` call is idempotent | Re-running it on an existing widget name skips existing files |
| One JSON file per DSL file | Multiple exports of the same file overwrite `exported_json/<file_name>.json` |
