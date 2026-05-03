/// Simple full-screen SDUI DSL example.
///
/// This screen has a hero banner, an info card section, and an action button.
/// Each section has its own Key so you can export the full screen OR any
/// individual part independently.
///
/// ═══════════════════════════════════════════════════════════════════════════
///  CLI COMMANDS  (run all from the example/ directory)
/// ═══════════════════════════════════════════════════════════════════════════
///
/// ── FULL SCREEN ─────────────────────────────────────────────────────────────
///
///   dart run sdui_library:sdui export simple_screen simple_screen
///
/// ── PARTIAL EXPORTS (sub-trees) ─────────────────────────────────────────────
///
///   dart run sdui_library:sdui export simple_screen hero_banner
///   dart run sdui_library:sdui export simple_screen info_card
///   dart run sdui_library:sdui export simple_screen action_button
///
/// ── SCAFFOLD A CUSTOM WIDGET ────────────────────────────────────────────────
///
///   dart run sdui_library:sdui add-widget MyBadge
///
/// ── HELP ────────────────────────────────────────────────────────────────────
///
///   dart run sdui_library:sdui --help
///
/// ═══════════════════════════════════════════════════════════════════════════
///  Output → example/exported_json/simple_screen.json
/// ═══════════════════════════════════════════════════════════════════════════
// ignore: depend_on_referenced_packages
import 'package:sdui_library/sdui_dsl.dart';

// NOTE: Never use '_' as the variable name — the CLI skips it.
// Use any real name; only the Key('...') value matters for export.
/// dart run sdui_library:sdui export simple_screen hero_banner

final simpleScreen = Column(
  key: Key('simple_screen'), // ← full screen export
  mainAxisAlignment: 'start',
  children: [
    // ── Hero banner ──────────────────────────────────────────────────────────
    //
    // Export: dart run sdui_library:sdui export simple_screen hero_banner
    Container(
      key: Key('hero_banner'),
      color: 'Colors.indigo',
      padding: {'horizontal': 24, 'vertical': 40},
      child: Column(
        crossAxisAlignment: 'start',
        children: [
          Row(
            mainAxisAlignment: 'spaceBetween',
            children: [
              Text(
                'Good morning 👋',
                fontSize: 14,
                color: '#C5CAE9',
                fontWeight: 'w400',
              ),
              Icon(icon: 'notifications_none', color: 'Colors.white', size: 24),
            ],
          ),
          Container(height: 8),
          Text(
            'Hello, SDUI!',
            fontSize: 30,
            fontWeight: 'bold',
            color: 'Colors.white',
          ),
          Container(height: 4),
          Text('Build UI from JSON — fast.', fontSize: 14, color: '#C5CAE9'),
        ],
      ),
    ),

    // ── Info card ────────────────────────────────────────────────────────────
    //
    // Export: dart run sdui_library:sdui export simple_screen info_card
    Padding(
      padding: {'horizontal': 16, 'vertical': 20},
      child: Card(
        key: Key('info_card'),
        elevation: 3,
        borderRadius: 16,
        child: Container(
          padding: {'horizontal': 20, 'vertical': 20},
          child: Column(
            crossAxisAlignment: 'start',
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    color: '#E8EAF6',
                    borderRadius: 12,
                    child: Center(
                      child: Icon(
                        icon: 'info_outline',
                        color: 'Colors.indigo',
                        size: 24,
                      ),
                    ),
                  ),
                  Container(width: 14),
                  Column(
                    crossAxisAlignment: 'start',
                    children: [
                      Text(
                        'What is SDUI?',
                        fontSize: 16,
                        fontWeight: 'bold',
                        color: '#1A237E',
                      ),
                      Text(
                        'Server-Driven UI for Flutter',
                        fontSize: 12,
                        color: '#5C6BC0',
                      ),
                    ],
                  ),
                ],
              ),
              Container(height: 16),
              Text(
                'Define your widget tree in Dart, export it to JSON with the CLI, '
                'serve it from your API, and render it dynamically in Flutter — '
                'no app update needed.',
                fontSize: 13,
                color: '#374151',
                height: 1.6,
              ),
            ],
          ),
        ),
      ),
    ),

    // ── Action button ────────────────────────────────────────────────────────
    //
    // Export: dart run sdui_library:sdui export simple_screen action_button
    Padding(
      padding: {'horizontal': 16},
      child: ElevatedButton(
        key: Key('action_button'),
        label: 'Export This Screen to JSON',
        backgroundColor: 'Colors.indigo',
        labelColor: 'Colors.white',
        borderRadius: 14,
        fontSize: 15,
        fontWeight: 'bold',
        padding: {'horizontal': 24, 'vertical': 16},
        icon: Icon(icon: 'download', color: 'Colors.white', size: 18),
        onTap: SduiAction(type: 'navigate', payload: {'route': '/export'}),
      ),
    ),

    Container(height: 12),

    // ── Secondary text button ─────────────────────────────────────────────────
    Padding(
      padding: {'horizontal': 16},
      child: TextButton(
        label: 'View JSON Output',
        labelColor: 'Colors.indigo',
        fontSize: 14,
        icon: Icon(icon: 'code', color: 'Colors.indigo', size: 16),
        onTap: SduiAction(type: 'navigate', payload: {'route': '/json_viewer'}),
      ),
    ),
  ],
);
