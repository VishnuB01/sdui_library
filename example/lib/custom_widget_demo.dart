import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdui_library/sdui_library.dart';

// ─── JSON definitions that use the custom RatingStars widget ─────────────────
//
// These are exactly the kind of payloads your server would send down.
// The `RatingStars` type is resolved via registerCustomWidgets() in main.dart.

const Map<String, dynamic> _productCardJson = {
  "widget": "Card",
  "properties": {"elevation": 4, "borderRadius": 16, "margin": 0},
  "child": {
    "widget": "Column",
    "properties": {"crossAxisAlignment": "start", "mainAxisSize": "min"},
    "children": [
      // Product image placeholder
      {
        "widget": "Container",
        "properties": {
          "height": 180,
          "gradient": {
            "type": "linear",
            "colors": ["#667EEA", "#764BA2"],
            "begin": "topLeft",
            "end": "bottomRight",
          },
          "borderRadius": {"tl": 16, "tr": 16, "bl": 0, "br": 0},
        },
        "child": {
          "widget": "Center",
          "child": {
            "widget": "Icon",
            "properties": {
              "icon": "headphones",
              "color": "#FFFFFF",
              "size": 72,
            },
          },
        },
      },
      // Product details
      {
        "widget": "Padding",
        "properties": {"padding": 16},
        "child": {
          "widget": "Column",
          "properties": {
            "crossAxisAlignment": "start",
            "mainAxisSize": "min",
          },
          "children": [
            {
              "widget": "Text",
              "properties": {
                "data": "Pro Wireless Headphones",
                "fontSize": 18,
                "fontWeight": "bold",
                "color": "#111827",
              },
            },
            {"widget": "Container", "properties": {"height": 6}},
            {
              "widget": "Text",
              "properties": {
                "data": "Active noise cancellation · 30h battery",
                "fontSize": 13,
                "color": "#6B7280",
              },
            },
            {"widget": "Container", "properties": {"height": 12}},
            // ✨ Custom RatingStars widget from JSON
            {
              "widget": "RatingStars",
              "properties": {
                "rating": 4.5,
                "maxStars": 5,
                "label": "4.5 (2,348 reviews)",
                "starColor": "#F59E0B",
                "inactiveStarColor": "#E5E7EB",
                "size": 20.0,
              },
            },
            {"widget": "Container", "properties": {"height": 16}},
            {
              "widget": "Row",
              "properties": {"mainAxisAlignment": "spaceBetween"},
              "children": [
                {
                  "widget": "Text",
                  "properties": {
                    "data": "\$149.99",
                    "fontSize": 22,
                    "fontWeight": "bold",
                    "color": "#6C63FF",
                  },
                },
                {
                  "widget": "ElevatedButton",
                  "properties": {
                    "label": "Add to Cart",
                    "backgroundColor": "#6C63FF",
                    "labelColor": "#FFFFFF",
                    "borderRadius": 10,
                    "fontSize": 14,
                    "fontWeight": "w600",
                    "padding": {"horizontal": 16, "vertical": 10},
                  },
                  "icon": {
                    "widget": "Icon",
                    "properties": {
                      "icon": "shopping_cart",
                      "color": "#FFFFFF",
                      "size": 16,
                    },
                  },
                  "onTap": {
                    "type": "add_to_cart",
                    "payload": {"productId": "headphones_pro_x1"},
                  },
                },
              ],
            },
          ],
        },
      },
    ],
  },
};

// A simple standalone rating widget rendered from JSON
const Map<String, dynamic> _starsOnlyJson = {
  "widget": "RatingStars",
  "properties": {
    "rating": 3.5,
    "maxStars": 5,
    "label": "3.5 — Good",
    "starColor": "#10B981",
    "size": 28.0,
  },
};

final Map<String, dynamic> _reviewListJson = {
  "widget": "ListView",
  "properties": {"shrinkWrap": true, "physics": "never", "padding": 0},
  "children": [
    _reviewItem("Sarah K.", 5.0, "Incredible sound quality!", "#6C63FF"),
    _reviewItem("James T.", 4.0, "Great build, slightly heavy.", "#3B82F6"),
    _reviewItem("Priya M.", 5.0, "Best headphones I've owned.", "#8B5CF6"),
  ],
};

Map<String, dynamic> _reviewItem(
  String name,
  double rating,
  String comment,
  String avatarColor,
) =>
    {
      "widget": "Card",
      "properties": {
        "elevation": 2,
        "borderRadius": 14,
        "margin": {"bottom": 10},
      },
      "child": {
        "widget": "Padding",
        "properties": {"padding": 14},
        "child": {
          "widget": "Column",
          "properties": {
            "crossAxisAlignment": "start",
            "mainAxisSize": "min",
          },
          "children": [
            {
              "widget": "Row",
              "properties": {"mainAxisAlignment": "spaceBetween"},
              "children": [
                {
                  "widget": "Row",
                  "children": [
                    {
                      "widget": "Container",
                      "properties": {
                        "width": 36,
                        "height": 36,
                        "color": avatarColor,
                        "borderRadius": 18,
                      },
                      "child": {
                        "widget": "Center",
                        "child": {
                          "widget": "Text",
                          "properties": {
                            "data": name[0],
                            "fontSize": 16,
                            "fontWeight": "bold",
                            "color": "#FFFFFF",
                          },
                        },
                      },
                    },
                    {"widget": "Container", "properties": {"width": 10}},
                    {
                      "widget": "Text",
                      "properties": {
                        "data": name,
                        "fontSize": 14,
                        "fontWeight": "w600",
                        "color": "#111827",
                      },
                    },
                  ],
                },
                // ✨ RatingStars inside each review card
                {
                  "widget": "RatingStars",
                  "properties": {
                    "rating": rating,
                    "maxStars": 5,
                    "starColor": "#F59E0B",
                    "size": 16.0,
                  },
                },
              ],
            },
            {"widget": "Container", "properties": {"height": 8}},
            {
              "widget": "Text",
              "properties": {
                "data": comment,
                "fontSize": 13,
                "color": "#6B7280",
              },
            },
          ],
        },
      },
    };

// ─── Demo page ────────────────────────────────────────────────────────────────

class CustomWidgetDemoPage extends StatefulWidget {
  const CustomWidgetDemoPage({super.key});

  @override
  State<CustomWidgetDemoPage> createState() => _CustomWidgetDemoPageState();
}

class _CustomWidgetDemoPageState extends State<CustomWidgetDemoPage> {
  bool _showJson = false;
  String _lastAction = 'Tap "Add to Cart" to see an action fire';

  void _handleAction(SduiAction action) {
    setState(() {
      _lastAction =
          '${action.type} → ${const JsonEncoder().convert(action.payload)}';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🛒 ${action.type}'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF6C63FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        title: const Text(
          'Custom Widgets via CLI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _showJson = !_showJson),
            icon: Icon(
              _showJson ? Icons.widgets_rounded : Icons.code_rounded,
              color: Colors.white,
            ),
            label: Text(
              _showJson ? 'UI' : 'JSON',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _showJson ? _buildJsonView() : _buildUiView(),
    );
  }

  // ── UI view ─────────────────────────────────────────────────────────────────

  Widget _buildUiView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── How it works banner ─────────────────────────────────────────────
          _howItWorksBanner(),
          const SizedBox(height: 20),

          // ── Standalone stars ────────────────────────────────────────────────
          _sectionLabel('RatingStars widget (standalone from JSON)'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SduiParser.buildWidget(_starsOnlyJson),
          ),
          const SizedBox(height: 20),

          // ── Product card with embedded stars ────────────────────────────────
          _sectionLabel('Product card (RatingStars embedded in JSON tree)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(_productCardJson, onAction: _handleAction),

          // ── Action log ──────────────────────────────────────────────────────
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  size: 18,
                  color: Color(0xFF6C63FF),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _lastAction,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF4C1D95),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Reviews list ────────────────────────────────────────────────────
          _sectionLabel('Reviews (RatingStars inside each review card)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(_reviewListJson, onAction: _handleAction),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── JSON source view ─────────────────────────────────────────────────────────

  Widget _buildJsonView() {
    final sections = [
      ('Standalone RatingStars JSON', _starsOnlyJson),
      ('Product Card JSON (with embedded RatingStars)', _productCardJson),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _howItWorksBanner(),
        const SizedBox(height: 20),
        ...sections.map((entry) {
          final (title, json) = entry;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel(title),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1B4B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  const JsonEncoder.withIndent('  ').convert(json),
                  style: const TextStyle(
                    color: Color(0xFF93C5FD),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ],
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Widget _howItWorksBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF4F46E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.terminal_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'dart run sdui add-widget RatingStars',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'The CLI scaffolded this widget automatically. '
            'We filled in the encoder + builder, called registerCustomWidgets() '
            'in main(), and now RatingStars is available anywhere in JSON.',
            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 12),
          _step('1', 'encoder', 'sdui_widgets/rating_stars/rating_stars_encoder.dart'),
          const SizedBox(height: 4),
          _step('2', 'builder', 'sdui_widgets/rating_stars/rating_stars_builder.dart'),
          const SizedBox(height: 4),
          _step('3', 'register', 'registerCustomWidgets() in main.dart'),
        ],
      ),
    );
  }

  Widget _step(String num, String tag, String path) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              num,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '[$tag] ',
                  style: const TextStyle(
                    color: Color(0xFF93C5FD),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: path,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF6C63FF),
        letterSpacing: 0.3,
      ),
    );
  }
}
