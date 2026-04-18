# SDUI Library — User Guide

A step-by-step guide to building a complete screen using **Server-Driven UI** in Flutter.

---

## Table of Contents

1. [Installation](#installation)
2. [Core Concepts](#core-concepts)
3. [Building Your First Screen](#building-your-first-screen)
4. [JSON Widget Reference](#json-widget-reference)
5. [Handling Actions (Buttons)](#handling-actions-buttons)
6. [Registering Custom Widgets](#registering-custom-widgets)
7. [The Fallback Widget](#the-fallback-widget)
8. [Complete Sample: Product Detail Screen](#complete-sample-product-detail-screen)

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  sdui_library:
    path: ./  # or your pub.dev version
```

Then import it wherever needed:

```dart
import 'package:sdui_library/sdui_library.dart';
```

---

## Core Concepts

| Concept | Description |
|---|---|
| `SduiParser.buildWidget(json)` | Converts a JSON map into a Flutter widget tree |
| `WidgetRegistry` | Stores builders for every supported widget type |
| `SduiAction` | Represents a user interaction (tap, press) dispatched from JSON |
| `SduiActionHandler` | Your callback that receives and handles `SduiAction` events |
| Fallback widget | Shown automatically when an unknown widget type is parsed |

### JSON Shape

Every widget in JSON follows this shape:

```json
{
  "widget": "<WidgetType>",
  "properties": { ... },
  "child": { ... },
  "children": [ ... ]
}
```

| Key | Required | Description |
|---|---|---|
| `widget` | ✅ | The Flutter widget type name (e.g. `"Text"`, `"Column"`) |
| `properties` | ❌ | Key-value pairs for that widget's configuration |
| `child` | ❌ | A single nested widget (for `Container`, `Center`, `Card`, etc.) |
| `children` | ❌ | A list of nested widgets (for `Column`, `Row`, `ListView`, etc.) |

---

## Building Your First Screen

### Step 1 — Define a JSON map

```dart
const Map<String, dynamic> welcomeScreen = {
  "widget": "Column",
  "properties": {
    "mainAxisAlignment": "center",
    "crossAxisAlignment": "center"
  },
  "children": [
    {
      "widget": "Icon",
      "properties": {
        "icon": "star",
        "color": "#FFD700",
        "size": 64
      }
    },
    {
      "widget": "Text",
      "properties": {
        "data": "Welcome to SDUI!",
        "fontSize": 24,
        "fontWeight": "bold",
        "color": "#1F2937",
        "textAlign": "center"
      }
    },
    {
      "widget": "Text",
      "properties": {
        "data": "Your UI is now driven by JSON.",
        "fontSize": 14,
        "color": "#6B7280",
        "textAlign": "center"
      }
    }
  ]
};
```

### Step 2 — Render it in Flutter

```dart
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SDUI Screen')),
      body: SduiParser.buildWidget(welcomeScreen),
    );
  }
}
```

That's it. The JSON is now a real Flutter `Column` with an `Icon` and two `Text` widgets. ✅

---

## JSON Widget Reference

### `Text`

```json
{
  "widget": "Text",
  "properties": {
    "data": "Hello World",
    "fontSize": 18,
    "fontWeight": "bold",
    "color": "#1F2937",
    "textAlign": "center",
    "maxLines": 2,
    "overflow": "ellipsis",
    "letterSpacing": 1.2,
    "height": 1.5,
    "decoration": "underline"
  }
}
```

| Property | Type | Values |
|---|---|---|
| `data` | String | The text to display |
| `fontSize` | Number | e.g. `16`, `24` |
| `fontWeight` | String | `normal`, `bold`, `w100`–`w900` |
| `color` | String | Hex color: `"#FF6B6B"` or `"#AARRGGBB"` |
| `textAlign` | String | `left`, `right`, `center`, `justify`, `start`, `end` |
| `maxLines` | Number | Max lines before clamping |
| `overflow` | String | `ellipsis`, `clip`, `fade`, `visible` |
| `letterSpacing` | Number | Space between characters |
| `height` | Number | Line height multiplier |
| `decoration` | String | `underline`, `lineThrough`, `overline`, `none` |

---

### `Container`

```json
{
  "widget": "Container",
  "properties": {
    "height": 100,
    "width": 200,
    "color": "#4ECDC4",
    "padding": 16,
    "margin": { "horizontal": 8, "vertical": 4 },
    "borderRadius": 12,
    "borderColor": "#000000",
    "borderWidth": 1.5,
    "alignment": "center",
    "gradient": {
      "type": "linear",
      "colors": ["#6C63FF", "#3B82F6"],
      "begin": "topLeft",
      "end": "bottomRight"
    }
  },
  "child": { ... }
}
```

**Padding / Margin** accepts:
- A number → `EdgeInsets.all(n)`
- `{ "horizontal": 8, "vertical": 4 }` → symmetric
- `{ "left": 8, "top": 4, "right": 8, "bottom": 4 }` → directional

**BorderRadius** accepts:
- A number → `BorderRadius.circular(n)`
- `{ "tl": 12, "tr": 12, "bl": 0, "br": 0 }` → per-corner

---

### `Column` / `Row`

```json
{
  "widget": "Column",
  "properties": {
    "mainAxisAlignment": "center",
    "crossAxisAlignment": "start",
    "mainAxisSize": "max"
  },
  "children": [ ... ]
}
```

| Property | Values |
|---|---|
| `mainAxisAlignment` | `start`, `end`, `center`, `spaceBetween`, `spaceAround`, `spaceEvenly` |
| `crossAxisAlignment` | `start`, `end`, `center`, `stretch`, `baseline` |
| `mainAxisSize` | `max`, `min` |

---

### `Card`

```json
{
  "widget": "Card",
  "properties": {
    "elevation": 4,
    "color": "#FFFFFF",
    "shadowColor": "#000000",
    "borderRadius": 16,
    "margin": 8
  },
  "child": { ... }
}
```

---

### `ElevatedButton` / `TextButton` / `OutlinedButton`

```json
{
  "widget": "ElevatedButton",
  "properties": {
    "label": "Get Started",
    "backgroundColor": "#6C63FF",
    "labelColor": "#FFFFFF",
    "borderRadius": 12,
    "fontSize": 16,
    "fontWeight": "w600",
    "padding": { "horizontal": 24, "vertical": 14 }
  },
  "icon": {
    "widget": "Icon",
    "properties": { "icon": "star", "color": "#FFFFFF", "size": 18 }
  },
  "onTap": {
    "type": "navigate",
    "payload": { "route": "/home" }
  }
}
```

> **Note:** `icon` is optional. When present, it renders to the left of the label.

---

### `Image`

```json
{
  "widget": "Image",
  "properties": {
    "src": "https://example.com/photo.jpg",
    "width": 300,
    "height": 200,
    "fit": "cover",
    "borderRadius": 12
  }
}
```

| `fit` values | `cover`, `contain`, `fill`, `fitWidth`, `fitHeight`, `none`, `scaleDown` |
|---|---|

---

### `Icon`

```json
{
  "widget": "Icon",
  "properties": {
    "icon": "star",
    "color": "#FFD700",
    "size": 32
  }
}
```

**Available icon names** (60+ supported):  
`home`, `back`, `forward`, `menu`, `close`, `search`, `settings`, `add`, `edit`, `delete`, `share`, `download`, `upload`, `refresh`, `filter`, `sort`, `check`, `check_circle`, `error`, `warning`, `info`, `play`, `pause`, `stop`, `camera`, `image`, `video`, `mic`, `email`, `phone`, `chat`, `notifications`, `star`, `star_border`, `favorite`, `favorite_border`, `bookmark`, `person`, `group`, `location`, `calendar`, `clock`, `cart`, `bag`, `payment`, `wallet`, `lock`, `unlock`, `visibility`, `thumb_up`, `thumb_down`, `link`, `bar_chart`, `pie_chart`, `trending_up`, `trending_down`, `qr_code`, ...

---

### `ListView`

```json
{
  "widget": "ListView",
  "properties": {
    "padding": 16,
    "shrinkWrap": true,
    "physics": "never",
    "scrollDirection": "vertical"
  },
  "children": [ ... ]
}
```

> Use `"shrinkWrap": true` and `"physics": "never"` when nesting a `ListView` inside a `Column` or `SingleChildScrollView`.

---

### `Stack`

```json
{
  "widget": "Stack",
  "properties": {
    "alignment": "bottomCenter",
    "fit": "loose"
  },
  "children": [ ... ]
}
```

---

### `Center` / `Padding`

```json
{ "widget": "Center", "child": { ... } }

{
  "widget": "Padding",
  "properties": { "padding": 16 },
  "child": { ... }
}
```

---

## Handling Actions (Buttons)

Since closures can't be stored in JSON, buttons dispatch an **`SduiAction`** object.
You provide an `onAction` handler when calling `buildWidget`:

```dart
// In your screen's State class:
void _handleAction(SduiAction action) {
  switch (action.type) {
    case 'navigate':
      final route = action.payload['route'] as String;
      Navigator.pushNamed(context, route);
      break;
    case 'follow':
      final userId = action.payload['userId'];
      print('Following user: $userId');
      break;
    case 'submit':
      // handle form submit
      break;
  }
}

// Pass it to buildWidget:
SduiParser.buildWidget(myJson, onAction: _handleAction)
```

### JSON side (button definition):

```json
{
  "widget": "ElevatedButton",
  "properties": { "label": "Follow" },
  "onTap": {
    "type": "follow",
    "payload": { "userId": "alex_johnson" }
  }
}
```

---

## Registering Custom Widgets

You can add any widget not built into the library. Call `SduiParser.registerWidget` **once** at app startup (before `runApp`):

```dart
void main() {
  // Register a custom "StatusBadge" widget
  SduiParser.registerWidget('StatusBadge', (json) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};
    final label = props['label'] as String? ?? '';
    final color = parseColor(props['color']);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  });

  runApp(const MyApp());
}
```

**Use it in JSON like any other widget:**

```json
{
  "widget": "StatusBadge",
  "properties": {
    "label": "Active",
    "color": "#22C55E"
  }
}
```

---

## The Fallback Widget

When the parser encounters an unknown widget type, it **does not crash**. Instead it renders a visible error container:

```
┌─────────────────────────────────────────────────────┐
│ ⚠  Can't find a widget like "MyWidget" that you     │
│    parsed from JSON.                                 │
└─────────────────────────────────────────────────────┘
```

This makes debugging easy during development. If you see this in your UI, check:
- The spelling of the `"widget"` value in your JSON
- That the widget was registered via `SduiParser.registerWidget()`

---

## Complete Sample: Product Detail Screen

Here's a full screen built entirely from JSON — a product detail page with a hero image, title, price, rating, a feature list, and an "Add to Cart" button.

### The JSON

```dart
const Map<String, dynamic> productDetailJson = {
  "widget": "ListView",
  "properties": {"padding": 0, "physics": "bouncing"},
  "children": [
    // ── Hero Image ──────────────────────────────────────────
    {
      "widget": "Stack",
      "properties": {"alignment": "bottomLeft"},
      "children": [
        {
          "widget": "Image",
          "properties": {
            "src": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800",
            "width": 400,
            "height": 300,
            "fit": "cover"
          }
        },
        {
          "widget": "Container",
          "properties": {
            "padding": {"horizontal": 16, "vertical": 12},
            "gradient": {
              "type": "linear",
              "colors": ["#00000000", "#CC000000"],
              "begin": "topCenter",
              "end": "bottomCenter"
            }
          },
          "child": {
            "widget": "Text",
            "properties": {
              "data": "Premium Watch",
              "fontSize": 28,
              "fontWeight": "bold",
              "color": "#FFFFFF"
            }
          }
        }
      ]
    },

    // ── Body ────────────────────────────────────────────────
    {
      "widget": "Container",
      "properties": {"padding": 20},
      "child": {
        "widget": "Column",
        "properties": {"crossAxisAlignment": "start"},
        "children": [

          // Price + Rating Row
          {
            "widget": "Row",
            "properties": {"mainAxisAlignment": "spaceBetween"},
            "children": [
              {
                "widget": "Text",
                "properties": {
                  "data": "\$249.99",
                  "fontSize": 26,
                  "fontWeight": "bold",
                  "color": "#6C63FF"
                }
              },
              {
                "widget": "Row",
                "properties": {"mainAxisSize": "min"},
                "children": [
                  {
                    "widget": "Icon",
                    "properties": {"icon": "star", "color": "#F59E0B", "size": 20}
                  },
                  {
                    "widget": "Text",
                    "properties": {
                      "data": " 4.8 (320 reviews)",
                      "fontSize": 13,
                      "color": "#6B7280"
                    }
                  }
                ]
              }
            ]
          },

          {"widget": "Container", "properties": {"height": 12}},

          // Description
          {
            "widget": "Text",
            "properties": {
              "data": "Crafted with precision and style. This premium timepiece features a sapphire crystal glass face and stainless steel case.",
              "fontSize": 14,
              "color": "#4B5563",
              "height": 1.6
            }
          },

          {"widget": "Container", "properties": {"height": 20}},

          // Features
          {
            "widget": "Text",
            "properties": {
              "data": "Key Features",
              "fontSize": 16,
              "fontWeight": "bold",
              "color": "#1F2937"
            }
          },
          {"widget": "Container", "properties": {"height": 10}},
          {
            "widget": "ListView",
            "properties": {"shrinkWrap": true, "physics": "never", "padding": 0},
            "children": [
              {
                "widget": "Row",
                "properties": {"mainAxisAlignment": "start"},
                "children": [
                  {"widget": "Icon", "properties": {"icon": "check_circle", "color": "#22C55E", "size": 18}},
                  {"widget": "Container", "properties": {"width": 8}},
                  {"widget": "Text", "properties": {"data": "Sapphire crystal glass", "fontSize": 14, "color": "#374151"}}
                ]
              },
              {"widget": "Container", "properties": {"height": 6}},
              {
                "widget": "Row",
                "properties": {"mainAxisAlignment": "start"},
                "children": [
                  {"widget": "Icon", "properties": {"icon": "check_circle", "color": "#22C55E", "size": 18}},
                  {"widget": "Container", "properties": {"width": 8}},
                  {"widget": "Text", "properties": {"data": "100m water resistance", "fontSize": 14, "color": "#374151"}}
                ]
              },
              {"widget": "Container", "properties": {"height": 6}},
              {
                "widget": "Row",
                "properties": {"mainAxisAlignment": "start"},
                "children": [
                  {"widget": "Icon", "properties": {"icon": "check_circle", "color": "#22C55E", "size": 18}},
                  {"widget": "Container", "properties": {"width": 8}},
                  {"widget": "Text", "properties": {"data": "2-year manufacturer warranty", "fontSize": 14, "color": "#374151"}}
                ]
              }
            ]
          },

          {"widget": "Container", "properties": {"height": 28}},

          // Add to Cart Button
          {
            "widget": "ElevatedButton",
            "properties": {
              "label": "Add to Cart",
              "backgroundColor": "#6C63FF",
              "labelColor": "#FFFFFF",
              "borderRadius": 14,
              "fontSize": 16,
              "fontWeight": "bold",
              "padding": {"horizontal": 32, "vertical": 16}
            },
            "icon": {
              "widget": "Icon",
              "properties": {"icon": "cart", "color": "#FFFFFF", "size": 20}
            },
            "onTap": {
              "type": "addToCart",
              "payload": {"productId": "watch-001", "price": 249.99}
            }
          }
        ]
      }
    }
  ]
};
```

### Rendering the Screen

```dart
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  void _handleAction(SduiAction action) {
    switch (action.type) {
      case 'addToCart':
        final id = action.payload['productId'];
        final price = action.payload['price'];
        print('Adding to cart: $id at \$$price');
        // Call your cart service here
        break;
      case 'navigate':
        // handle navigation
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: SduiParser.buildWidget(
        productDetailJson,
        onAction: _handleAction,
      ),
    );
  }
}
```

### Result

| Section | Widget used | Key properties |
|---|---|---|
| Hero image + overlay | `Stack` → `Image` + `Container` gradient | `fit: cover`, linear gradient |
| Price + rating row | `Row` → `Text` + `Icon` | `spaceBetween`, `#F59E0B` star |
| Description | `Text` | `height: 1.6` for line spacing |
| Feature checklist | `ListView` → `Row` → `Icon` + `Text` | `shrinkWrap: true`, `physics: never` |
| CTA button | `ElevatedButton` with `icon` | `onTap` dispatches `addToCart` action |

---

## Quick Reference Cheat Sheet

```
┌─────────────────────────────────┬──────────────────────┐
│ Widget                          │ Supports             │
├─────────────────────────────────┼──────────────────────┤
│ Text                            │ child: ✗             │
│ Container                       │ child: ✅            │
│ Column / Row                    │ children: ✅         │
│ Center / Padding                │ child: ✅            │
│ Stack                           │ children: ✅         │
│ Card                            │ child: ✅            │
│ ListView                        │ children: ✅         │
│ Image                           │ child: ✗             │
│ Icon                            │ child: ✗             │
│ ElevatedButton                  │ icon + onTap         │
│ TextButton                      │ icon + onTap         │
│ OutlinedButton                  │ icon + onTap         │
│ <YourCustomWidget>              │ anything you define  │
└─────────────────────────────────┴──────────────────────┘
```
