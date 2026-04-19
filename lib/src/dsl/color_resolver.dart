/// Resolves a color value string into a hex color string compatible
/// with the SDUI library's JSON format.
///
/// Accepts two formats:
/// - **Flutter color names**: `'Colors.red'`, `'Colors.blue.shade700'`, etc.
/// - **Hex strings**: `'#FF6B6B'`, `'#4ECDC4'`, `'#00000000'`, etc.
///
/// ### Example
/// ```dart
/// resolveColor('Colors.red')        // → '#F44336'
/// resolveColor('Colors.blue.shade700') // → '#1976D2'
/// resolveColor('#FF6B6B')           // → '#FF6B6B'
/// resolveColor(null)                // → null
/// ```
String? resolveColor(String? value) {
  if (value == null) return null;

  // Already a hex string — pass through unchanged
  if (value.startsWith('#')) return value;

  // Flutter color name → hex lookup
  const flutterColors = <String, String>{
    // ── Reds ──────────────────────────────────────────────────────────────────
    'Colors.red': '#F44336',
    'Colors.red.shade50': '#FFEBEE',
    'Colors.red.shade100': '#FFCDD2',
    'Colors.red.shade200': '#EF9A9A',
    'Colors.red.shade300': '#E57373',
    'Colors.red.shade400': '#EF5350',
    'Colors.red.shade500': '#F44336',
    'Colors.red.shade600': '#E53935',
    'Colors.red.shade700': '#D32F2F',
    'Colors.red.shade800': '#C62828',
    'Colors.red.shade900': '#B71C1C',
    // ── Pinks ─────────────────────────────────────────────────────────────────
    'Colors.pink': '#E91E63',
    'Colors.pink.shade100': '#F48FB1',
    'Colors.pink.shade200': '#F06292',
    'Colors.pink.shade300': '#EC407A',
    'Colors.pink.shade400': '#E91E63',
    'Colors.pink.shade700': '#C2185B',
    'Colors.pink.shade900': '#880E4F',
    // ── Purples ───────────────────────────────────────────────────────────────
    'Colors.purple': '#9C27B0',
    'Colors.purple.shade100': '#E1BEE7',
    'Colors.purple.shade200': '#CE93D8',
    'Colors.purple.shade300': '#BA68C8',
    'Colors.purple.shade400': '#AB47BC',
    'Colors.purple.shade700': '#7B1FA2',
    'Colors.purple.shade900': '#4A148C',
    'Colors.deepPurple': '#673AB7',
    'Colors.deepPurple.shade700': '#512DA8',
    // ── Indigo / Blues ────────────────────────────────────────────────────────
    'Colors.indigo': '#3F51B5',
    'Colors.indigo.shade700': '#303F9F',
    'Colors.blue': '#2196F3',
    'Colors.blue.shade50': '#E3F2FD',
    'Colors.blue.shade100': '#BBDEFB',
    'Colors.blue.shade200': '#90CAF9',
    'Colors.blue.shade300': '#64B5F6',
    'Colors.blue.shade400': '#42A5F5',
    'Colors.blue.shade500': '#2196F3',
    'Colors.blue.shade600': '#1E88E5',
    'Colors.blue.shade700': '#1976D2',
    'Colors.blue.shade800': '#1565C0',
    'Colors.blue.shade900': '#0D47A1',
    'Colors.lightBlue': '#03A9F4',
    'Colors.lightBlue.shade700': '#0288D1',
    // ── Cyans / Teals ─────────────────────────────────────────────────────────
    'Colors.cyan': '#00BCD4',
    'Colors.cyan.shade700': '#0097A7',
    'Colors.teal': '#009688',
    'Colors.teal.shade100': '#B2DFDB',
    'Colors.teal.shade200': '#80CBC4',
    'Colors.teal.shade300': '#4DB6AC',
    'Colors.teal.shade400': '#26A69A',
    'Colors.teal.shade700': '#00796B',
    'Colors.teal.shade900': '#004D40',
    // ── Greens ────────────────────────────────────────────────────────────────
    'Colors.green': '#4CAF50',
    'Colors.green.shade50': '#E8F5E9',
    'Colors.green.shade100': '#C8E6C9',
    'Colors.green.shade200': '#A5D6A7',
    'Colors.green.shade300': '#81C784',
    'Colors.green.shade400': '#66BB6A',
    'Colors.green.shade500': '#4CAF50',
    'Colors.green.shade600': '#43A047',
    'Colors.green.shade700': '#388E3C',
    'Colors.green.shade800': '#2E7D32',
    'Colors.green.shade900': '#1B5E20',
    'Colors.lightGreen': '#8BC34A',
    'Colors.lightGreen.shade700': '#689F38',
    'Colors.lime': '#CDDC39',
    'Colors.lime.shade700': '#AFB42B',
    // ── Yellows / Ambers ──────────────────────────────────────────────────────
    'Colors.yellow': '#FFEB3B',
    'Colors.yellow.shade700': '#F9A825',
    'Colors.amber': '#FFC107',
    'Colors.amber.shade100': '#FFE082',
    'Colors.amber.shade200': '#FFD54F',
    'Colors.amber.shade400': '#FFCA28',
    'Colors.amber.shade700': '#FFA000',
    'Colors.amber.shade900': '#FF6F00',
    // ── Oranges ───────────────────────────────────────────────────────────────
    'Colors.orange': '#FF9800',
    'Colors.orange.shade100': '#FFE0B2',
    'Colors.orange.shade200': '#FFCC80',
    'Colors.orange.shade300': '#FFB74D',
    'Colors.orange.shade400': '#FFA726',
    'Colors.orange.shade700': '#F57C00',
    'Colors.orange.shade900': '#E65100',
    'Colors.deepOrange': '#FF5722',
    'Colors.deepOrange.shade700': '#E64A19',
    // ── Browns ────────────────────────────────────────────────────────────────
    'Colors.brown': '#795548',
    'Colors.brown.shade100': '#D7CCC8',
    'Colors.brown.shade200': '#BCAAA4',
    'Colors.brown.shade700': '#5D4037',
    // ── Neutrals ──────────────────────────────────────────────────────────────
    'Colors.grey': '#9E9E9E',
    'Colors.grey.shade50': '#FAFAFA',
    'Colors.grey.shade100': '#F5F5F5',
    'Colors.grey.shade200': '#EEEEEE',
    'Colors.grey.shade300': '#E0E0E0',
    'Colors.grey.shade400': '#BDBDBD',
    'Colors.grey.shade500': '#9E9E9E',
    'Colors.grey.shade600': '#757575',
    'Colors.grey.shade700': '#616161',
    'Colors.grey.shade800': '#424242',
    'Colors.grey.shade900': '#212121',
    'Colors.blueGrey': '#607D8B',
    'Colors.blueGrey.shade100': '#CFD8DC',
    'Colors.blueGrey.shade200': '#B0BEC5',
    'Colors.blueGrey.shade700': '#455A64',
    'Colors.blueGrey.shade900': '#263238',
    // ── Black / White ─────────────────────────────────────────────────────────
    'Colors.black': '#000000',
    'Colors.black12': '#1F000000',
    'Colors.black26': '#42000000',
    'Colors.black45': '#73000000',
    'Colors.black54': '#8A000000',
    'Colors.black87': '#DE000000',
    'Colors.white': '#FFFFFF',
    'Colors.white10': '#1AFFFFFF',
    'Colors.white12': '#1FFFFFFF',
    'Colors.white24': '#3DFFFFFF',
    'Colors.white30': '#4DFFFFFF',
    'Colors.white38': '#61FFFFFF',
    'Colors.white54': '#8AFFFFFF',
    'Colors.white60': '#99FFFFFF',
    'Colors.white70': '#B3FFFFFF',
    // ── Transparent ───────────────────────────────────────────────────────────
    'Colors.transparent': '#00000000',
  };

  return flutterColors[value] ?? value;
}
