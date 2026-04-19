/// Example DSL file demonstrating how to define SDUI widget trees
/// using Flutter-like syntax for CLI export.
///
/// Run:
/// ```bash
/// dart run sdui export home_screen home_screen   # export full screen
/// dart run sdui export home_screen hero_card     # export just the card
/// dart run sdui export home_screen action_row    # export just the button row
/// ```
///
/// Output goes to: exported_json/home_screen.json
// ignore: depend_on_referenced_packages
import 'package:sdui_library/sdui_dsl.dart';

// ─────────────────────────────────────────────────────────────────────────────
// The DSL supports StatelessWidget and Widget aliases to make definitions
// perfectly match your Flutter codebase instincts.
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('home_screen'), // ← export the full screen with this key
      mainAxisAlignment: 'start',
      children: [
        // ── Hero card ────────────────────────────────────────────────────────────
        Container(
          key: Key('hero_card'), // ← or export just this container
          height: 220,
          color: 'Colors.indigo',
          borderRadius: {'tl': 0, 'tr': 0, 'bl': 32, 'br': 32},
          padding: {'horizontal': 24, 'vertical': 32},
          child: Column(
            mainAxisAlignment: 'center',
            crossAxisAlignment: 'start',
            children: [
              Row(
                mainAxisAlignment: 'spaceBetween',
                children: [
                  Text(
                    'Welcome back 👋',
                    fontSize: 14,
                    color: 'Colors.white70',
                    fontWeight: 'w400',
                  ),
                  Icon(icon: 'notifications', color: 'Colors.white', size: 24),
                ],
              ),
              Container(height: 8),
              Text(
                'Flutter Dev',
                fontSize: 28,
                color: 'Colors.white',
                fontWeight: 'bold',
              ),
              Container(height: 4),
              Text(
                'Build. Export. Ship.',
                fontSize: 14,
                color: 'Colors.white70',
              ),
            ],
          ),
        ),

        // ── Stats row ────────────────────────────────────────────────────────────
        Padding(
          padding: {'horizontal': 16, 'vertical': 20},
          child: Row(
            key: Key('stats_row'), // ← exportable subtree
            mainAxisAlignment: 'spaceBetween',
            children: [
              _statCard('12', 'Screens', 'Colors.indigo.shade50'),
              _statCard('48', 'Components', 'Colors.teal.shade50'),
              _statCard('5', 'Exports', 'Colors.amber.shade50'),
            ],
          ),
        ),

        // ── Action buttons ───────────────────────────────────────────────────────
        Padding(
          padding: {'horizontal': 16},
          child: Column(
            key: Key('action_row'), // ← exportable subtree
            children: [
              ElevatedButton(
                label: 'Export New Screen',
                backgroundColor: 'Colors.indigo',
                labelColor: 'Colors.white',
                borderRadius: 12,
                fontSize: 16,
                fontWeight: 'bold',
                padding: {'horizontal': 24, 'vertical': 16},
                icon: Icon(icon: 'download', color: 'Colors.white', size: 18),
                onTap: SduiAction(
                  type: 'navigate',
                  payload: {'route': '/export'},
                ),
              ),
              Container(height: 12),
              OutlinedButton(
                label: 'View JSON Files',
                labelColor: 'Colors.indigo',
                borderColor: 'Colors.indigo',
                borderWidth: 1.5,
                borderRadius: 12,
                fontSize: 16,
                padding: {'horizontal': 24, 'vertical': 16},
                icon: Icon(icon: 'edit', color: 'Colors.indigo', size: 18),
                onTap: SduiAction(
                  type: 'navigate',
                  payload: {'route': '/json_files'},
                ),
              ),
            ],
          ),
        ),

        // ── Recent items list ────────────────────────────────────────────────────
        Padding(
          padding: {'horizontal': 16, 'vertical': 12},
          child: Column(
            key: Key('recent_list'), // ← exportable subtree
            crossAxisAlignment: 'start',
            children: [
              Text(
                'Recent Exports',
                fontSize: 18,
                fontWeight: 'bold',
                color: 'Colors.grey.shade800',
              ),
              Container(height: 12),
              _recentItem('home_screen.json', 'Colors.indigo.shade50', 'home'),
              Container(height: 8),
              _recentItem('product_card.json', 'Colors.teal.shade50', 'cart'),
              Container(height: 8),
              _recentItem('login_form.json', 'Colors.amber.shade50', 'lock'),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper functions that build reusable sub-trees (no Key needed on helpers)
// ─────────────────────────────────────────────────────────────────────────────

Widget _statCard(String value, String label, String bgColor) {
  return Column(
    children: [
      Container(
        padding: {'horizontal': 16, 'vertical': 12},
        color: bgColor,
        borderRadius: 12,
        child: Column(
          mainAxisAlignment: 'center',
          children: [
            Text(value,
                fontSize: 22,
                fontWeight: 'bold',
                color: 'Colors.grey.shade800'),
            Text(label, fontSize: 11, color: 'Colors.grey.shade600'),
          ],
        ),
      ),
    ],
  );
}

Widget _recentItem(String name, String bgColor, String iconName) {
  return Container(
    color: bgColor,
    borderRadius: 10,
    padding: {'horizontal': 16, 'vertical': 12},
    child: Row(
      mainAxisAlignment: 'spaceBetween',
      children: [
        Row(
          children: [
            Icon(icon: iconName, color: 'Colors.indigo', size: 20),
            Container(width: 12),
            Text(name,
                fontSize: 14,
                fontWeight: 'w500',
                color: 'Colors.grey.shade800'),
          ],
        ),
        Icon(icon: 'forward', color: 'Colors.grey', size: 18),
      ],
    ),
  );
}
