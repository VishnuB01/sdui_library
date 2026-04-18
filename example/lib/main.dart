import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdui_library/sdui_library.dart';

void main() {
  // Register a custom widget before running
  SduiParser.registerWidget('MyBadge', (json) {
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

  runApp(const SduiExampleApp());
}

// ─── Sample JSON Definitions ───────────────────────────────────────────────────

const Map<String, dynamic> profileCardJson = {
  "widget": "Card",
  "properties": {"elevation": 6, "borderRadius": 20, "margin": 0},
  "child": {
    "widget": "Container",
    "properties": {
      "padding": 20,
      "gradient": {
        "type": "linear",
        "colors": ["#6C63FF", "#3B82F6"],
        "begin": "topLeft",
        "end": "bottomRight",
      },
      "borderRadius": 20,
    },
    "child": {
      "widget": "Column",
      "properties": {"crossAxisAlignment": "start", "mainAxisSize": "min"},
      "children": [
        {
          "widget": "Row",
          "properties": {"mainAxisAlignment": "spaceBetween"},
          "children": [
            {
              "widget": "Column",
              "properties": {
                "crossAxisAlignment": "start",
                "mainAxisSize": "min",
              },
              "children": [
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Vishnu Prakash",
                    "fontSize": 22,
                    "fontWeight": "bold",
                    "color": "#FFFFFF",
                  },
                },
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Flutter Developer",
                    "fontSize": 14,
                    "color": "#C7D2FE",
                  },
                },
              ],
            },
            {
              "widget": "Icon",
              "properties": {"icon": "person", "color": "#FFFFFF", "size": 40},
            },
          ],
        },
        {
          "widget": "Container",
          "properties": {"height": 16},
        },
        {
          "widget": "Row",
          "properties": {"mainAxisAlignment": "start"},
          "children": [
            {
              "widget": "MyBadge",
              "properties": {"label": "Pro", "color": "#22C55E"},
            },
            {
              "widget": "Container",
              "properties": {"width": 8},
            },
            {
              "widget": "MyBadge",
              "properties": {"label": "Verified", "color": "#F59E0B"},
            },
          ],
        },
      ],
    },
  },
};

const Map<String, dynamic> statsRowJson = {
  "widget": "Row",
  "properties": {"mainAxisAlignment": "spaceBetween"},
  "children": [
    {
      "widget": "Card",
      "properties": {"elevation": 3, "borderRadius": 16, "margin": 0},
      "child": {
        "widget": "Container",
        "properties": {"padding": 16, "width": 100},
        "child": {
          "widget": "Column",
          "properties": {"crossAxisAlignment": "center", "mainAxisSize": "min"},
          "children": [
            {
              "widget": "Icon",
              "properties": {
                "icon": "trending_up",
                "color": "#22C55E",
                "size": 28,
              },
            },
            {
              "widget": "Text",
              "properties": {
                "data": "2.4K",
                "fontSize": 20,
                "fontWeight": "bold",
                "color": "#1F2937",
              },
            },
            {
              "widget": "Text",
              "properties": {
                "data": "Followers",
                "fontSize": 12,
                "color": "#6B7280",
              },
            },
          ],
        },
      },
    },
    {
      "widget": "Card",
      "properties": {"elevation": 3, "borderRadius": 16, "margin": 0},
      "child": {
        "widget": "Container",
        "properties": {"padding": 16, "width": 100},
        "child": {
          "widget": "Column",
          "properties": {"crossAxisAlignment": "center", "mainAxisSize": "min"},
          "children": [
            {
              "widget": "Icon",
              "properties": {"icon": "star", "color": "#F59E0B", "size": 28},
            },
            {
              "widget": "Text",
              "properties": {
                "data": "4.9",
                "fontSize": 20,
                "fontWeight": "bold",
                "color": "#1F2937",
              },
            },
            {
              "widget": "Text",
              "properties": {
                "data": "Rating",
                "fontSize": 12,
                "color": "#6B7280",
              },
            },
          ],
        },
      },
    },
    {
      "widget": "Card",
      "properties": {"elevation": 3, "borderRadius": 16, "margin": 0},
      "child": {
        "widget": "Container",
        "properties": {"padding": 16, "width": 100},
        "child": {
          "widget": "Column",
          "properties": {"crossAxisAlignment": "center", "mainAxisSize": "min"},
          "children": [
            {
              "widget": "Icon",
              "properties": {
                "icon": "check_circle",
                "color": "#6C63FF",
                "size": 28,
              },
            },
            {
              "widget": "Text",
              "properties": {
                "data": "128",
                "fontSize": 20,
                "fontWeight": "bold",
                "color": "#1F2937",
              },
            },
            {
              "widget": "Text",
              "properties": {
                "data": "Projects",
                "fontSize": 12,
                "color": "#6B7280",
              },
            },
          ],
        },
      },
    },
  ],
};

const Map<String, dynamic> actionsRowJson = {
  "widget": "Row",
  "properties": {"mainAxisAlignment": "spaceEvenly"},
  "children": [
    {
      "widget": "ElevatedButton",
      "properties": {
        "label": "Follow",
        "backgroundColor": "#6C63FF",
        "labelColor": "#FFFFFF",
        "borderRadius": 12,
        "fontSize": 15,
        "fontWeight": "w600",
        "padding": {"horizontal": 28, "vertical": 14},
      },
      "icon": {
        "widget": "Icon",
        "properties": {"icon": "person", "color": "#FFFFFF", "size": 18},
      },
      "onTap": {
        "type": "follow",
        "payload": {"userId": "alex_johnson"},
      },
    },
    {
      "widget": "OutlinedButton",
      "properties": {
        "label": "Message",
        "labelColor": "#6C63FF",
        "borderColor": "#6C63FF",
        "borderRadius": 12,
        "fontSize": 15,
        "fontWeight": "w600",
        "padding": {"horizontal": 24, "vertical": 14},
      },
      "icon": {
        "widget": "Icon",
        "properties": {"icon": "chat", "color": "#6C63FF", "size": 18},
      },
      "onTap": {
        "type": "navigate",
        "payload": {"route": "/chat", "userId": "alex_johnson"},
      },
    },
  ],
};

// A card demonstrating the fallback widget for unknown types
const Map<String, dynamic> unknownWidgetJson = {
  "widget": "SuperFancyWidget3000",
  "properties": {"data": "This widget does not exist"},
};

const Map<String, dynamic> featureListJson = {
  "widget": "ListView",
  "properties": {"shrinkWrap": true, "physics": "never", "padding": 0},
  "children": [
    {
      "widget": "Card",
      "properties": {
        "elevation": 2,
        "borderRadius": 14,
        "margin": {"bottom": 10},
      },
      "child": {
        "widget": "Container",
        "properties": {"padding": 16},
        "child": {
          "widget": "Row",
          "properties": {"mainAxisAlignment": "start"},
          "children": [
            {
              "widget": "Container",
              "properties": {
                "width": 44,
                "height": 44,
                "color": "#EDE9FE",
                "borderRadius": 12,
              },
              "child": {
                "widget": "Center",
                "child": {
                  "widget": "Icon",
                  "properties": {
                    "icon": "notifications",
                    "color": "#6C63FF",
                    "size": 22,
                  },
                },
              },
            },
            {
              "widget": "Container",
              "properties": {"width": 14},
            },
            {
              "widget": "Column",
              "properties": {
                "crossAxisAlignment": "start",
                "mainAxisSize": "min",
              },
              "children": [
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Push Notifications",
                    "fontSize": 15,
                    "fontWeight": "w600",
                    "color": "#1F2937",
                  },
                },
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Real-time alerts from the server",
                    "fontSize": 12,
                    "color": "#6B7280",
                  },
                },
              ],
            },
          ],
        },
      },
    },
    {
      "widget": "Card",
      "properties": {
        "elevation": 2,
        "borderRadius": 14,
        "margin": {"bottom": 10},
      },
      "child": {
        "widget": "Container",
        "properties": {"padding": 16},
        "child": {
          "widget": "Row",
          "properties": {"mainAxisAlignment": "start"},
          "children": [
            {
              "widget": "Container",
              "properties": {
                "width": 44,
                "height": 44,
                "color": "#DCFCE7",
                "borderRadius": 12,
              },
              "child": {
                "widget": "Center",
                "child": {
                  "widget": "Icon",
                  "properties": {
                    "icon": "bar_chart",
                    "color": "#22C55E",
                    "size": 22,
                  },
                },
              },
            },
            {
              "widget": "Container",
              "properties": {"width": 14},
            },
            {
              "widget": "Column",
              "properties": {
                "crossAxisAlignment": "start",
                "mainAxisSize": "min",
              },
              "children": [
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Dynamic Analytics",
                    "fontSize": 15,
                    "fontWeight": "w600",
                    "color": "#1F2937",
                  },
                },
                {
                  "widget": "Text",
                  "properties": {
                    "data": "Charts and widgets from JSON",
                    "fontSize": 12,
                    "color": "#6B7280",
                  },
                },
              ],
            },
          ],
        },
      },
    },
  ],
};

// ─── App ──────────────────────────────────────────────────────────────────────

class SduiExampleApp extends StatelessWidget {
  const SduiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDUI Library Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SduiDemoPage(),
    );
  }
}

class SduiDemoPage extends StatefulWidget {
  const SduiDemoPage({super.key});

  @override
  State<SduiDemoPage> createState() => _SduiDemoPageState();
}

class _SduiDemoPageState extends State<SduiDemoPage> {
  String _lastAction = 'No action yet';
  bool _showRawJson = false;

  void _handleAction(SduiAction action) {
    setState(() {
      _lastAction =
          'Action: ${action.type}\nPayload: ${jsonEncode(action.payload)}';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🚀 ${action.type} → ${jsonEncode(action.payload)}'),
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
          'SDUI Library Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _showRawJson = !_showRawJson),
            icon: Icon(
              _showRawJson ? Icons.widgets : Icons.code,
              color: Colors.white,
            ),
            label: Text(
              _showRawJson ? 'UI' : 'JSON',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: _showRawJson ? _buildJsonView() : _buildUiView(),
    );
  }

  Widget _buildUiView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Profile Card (gradient + custom widget)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(profileCardJson, onAction: _handleAction),

          const SizedBox(height: 20),
          _sectionLabel('Stats Row (nested cards)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(statsRowJson, onAction: _handleAction),

          const SizedBox(height: 20),
          _sectionLabel('Action Buttons (dispatches SduiAction)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(actionsRowJson, onAction: _handleAction),

          const SizedBox(height: 12),
          // Action log
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📋 Action Log',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C1D95),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _lastAction,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF5B21B6),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _sectionLabel('Feature List (ListView in JSON)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(featureListJson, onAction: _handleAction),

          const SizedBox(height: 20),
          _sectionLabel('⚠️ Fallback Widget (unknown type)'),
          const SizedBox(height: 8),
          SduiParser.buildWidget(unknownWidgetJson, onAction: _handleAction),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildJsonView() {
    final sections = [
      ('Profile Card JSON', profileCardJson),
      ('Stats Row JSON', statsRowJson),
      ('Action Buttons JSON', actionsRowJson),
      ('Feature List JSON', featureListJson),
      ('Unknown Widget JSON (fallback)', unknownWidgetJson),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: sections.map((entry) {
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
      }).toList(),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF6C63FF),
        letterSpacing: 0.5,
      ),
    );
  }
}
