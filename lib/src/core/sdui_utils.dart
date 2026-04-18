import 'package:flutter/material.dart';

/// Parses a hex color string (e.g. "#FF6B6B" or "FF6B6B") into a [Color].
Color parseColor(dynamic value) {
  if (value == null) return Colors.transparent;
  if (value is int) return Color(value);
  if (value is String) {
    String hex = value.replaceAll('#', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    }
  }
  return Colors.transparent;
}

/// Parses a [MainAxisAlignment] from a string.
MainAxisAlignment parseMainAxisAlignment(String? value) {
  switch (value) {
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    case 'center':
      return MainAxisAlignment.center;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
    default:
      return MainAxisAlignment.start;
  }
}

/// Parses a [CrossAxisAlignment] from a string.
CrossAxisAlignment parseCrossAxisAlignment(String? value) {
  switch (value) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'baseline':
      return CrossAxisAlignment.baseline;
    default:
      return CrossAxisAlignment.center;
  }
}

/// Parses a [MainAxisSize] from a string.
MainAxisSize parseMainAxisSize(String? value) {
  switch (value) {
    case 'min':
      return MainAxisSize.min;
    case 'max':
    default:
      return MainAxisSize.max;
  }
}

/// Parses an [Alignment] from a string.
Alignment parseAlignment(String? value) {
  switch (value) {
    case 'topLeft':
      return Alignment.topLeft;
    case 'topCenter':
      return Alignment.topCenter;
    case 'topRight':
      return Alignment.topRight;
    case 'centerLeft':
      return Alignment.centerLeft;
    case 'center':
      return Alignment.center;
    case 'centerRight':
      return Alignment.centerRight;
    case 'bottomLeft':
      return Alignment.bottomLeft;
    case 'bottomCenter':
      return Alignment.bottomCenter;
    case 'bottomRight':
      return Alignment.bottomRight;
    default:
      return Alignment.center;
  }
}

/// Parses a [FontWeight] from a string.
FontWeight parseFontWeight(String? value) {
  switch (value) {
    case 'w100':
      return FontWeight.w100;
    case 'w200':
      return FontWeight.w200;
    case 'w300':
      return FontWeight.w300;
    case 'normal':
    case 'w400':
      return FontWeight.w400;
    case 'w500':
      return FontWeight.w500;
    case 'w600':
      return FontWeight.w600;
    case 'bold':
    case 'w700':
      return FontWeight.w700;
    case 'w800':
      return FontWeight.w800;
    case 'w900':
      return FontWeight.w900;
    default:
      return FontWeight.normal;
  }
}

/// Parses a [TextAlign] from a string.
TextAlign parseTextAlign(String? value) {
  switch (value) {
    case 'left':
      return TextAlign.left;
    case 'right':
      return TextAlign.right;
    case 'center':
      return TextAlign.center;
    case 'justify':
      return TextAlign.justify;
    case 'start':
      return TextAlign.start;
    case 'end':
      return TextAlign.end;
    default:
      return TextAlign.start;
  }
}

/// Parses a [TextOverflow] from a string.
TextOverflow parseTextOverflow(String? value) {
  switch (value) {
    case 'ellipsis':
      return TextOverflow.ellipsis;
    case 'clip':
      return TextOverflow.clip;
    case 'fade':
      return TextOverflow.fade;
    case 'visible':
      return TextOverflow.visible;
    default:
      return TextOverflow.clip;
  }
}

/// Parses a [BoxFit] from a string.
BoxFit parseBoxFit(String? value) {
  switch (value) {
    case 'fill':
      return BoxFit.fill;
    case 'contain':
      return BoxFit.contain;
    case 'cover':
      return BoxFit.cover;
    case 'fitWidth':
      return BoxFit.fitWidth;
    case 'fitHeight':
      return BoxFit.fitHeight;
    case 'none':
      return BoxFit.none;
    case 'scaleDown':
      return BoxFit.scaleDown;
    default:
      return BoxFit.cover;
  }
}

/// Parses a [BorderRadius] from a value.
/// Accepts: a single num (uniform), or a Map with keys tl/tr/bl/br.
BorderRadius parseBorderRadius(dynamic value) {
  if (value == null) return BorderRadius.zero;
  if (value is num) {
    return BorderRadius.circular(value.toDouble());
  }
  if (value is Map<String, dynamic>) {
    return BorderRadius.only(
      topLeft: Radius.circular((value['tl'] as num? ?? 0).toDouble()),
      topRight: Radius.circular((value['tr'] as num? ?? 0).toDouble()),
      bottomLeft: Radius.circular((value['bl'] as num? ?? 0).toDouble()),
      bottomRight: Radius.circular((value['br'] as num? ?? 0).toDouble()),
    );
  }
  return BorderRadius.zero;
}

/// Parses [EdgeInsets] from a value.
/// Accepts: a single num (all sides), or a Map with keys all/horizontal/vertical/left/top/right/bottom.
EdgeInsets parseEdgeInsets(dynamic value) {
  if (value == null) return EdgeInsets.zero;
  if (value is num) {
    return EdgeInsets.all(value.toDouble());
  }
  if (value is Map<String, dynamic>) {
    if (value.containsKey('all')) {
      return EdgeInsets.all((value['all'] as num).toDouble());
    }
    return EdgeInsets.only(
      left: (value['left'] as num? ?? value['horizontal'] as num? ?? 0).toDouble(),
      top: (value['top'] as num? ?? value['vertical'] as num? ?? 0).toDouble(),
      right: (value['right'] as num? ?? value['horizontal'] as num? ?? 0).toDouble(),
      bottom: (value['bottom'] as num? ?? value['vertical'] as num? ?? 0).toDouble(),
    );
  }
  return EdgeInsets.zero;
}

/// Safely converts a dynamic value to double.
double? toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
