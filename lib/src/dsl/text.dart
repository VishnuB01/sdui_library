import 'color_resolver.dart';
import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for a [Text] widget.
///
/// ### Usage
/// ```dart
/// Text(
///   'Hello, World!',
///   key: Key('headline'),
///   fontSize: 24,
///   color: 'Colors.indigo.shade700',
///   fontWeight: 'bold',
///   textAlign: 'center',
///   maxLines: 2,
///   overflow: 'ellipsis',
///   letterSpacing: 1.2,
///   height: 1.5,
///   fontFamily: 'Roboto',
///   decoration: 'underline',
/// )
/// ```
///
/// Supported [fontWeight]: `normal`, `bold`, `w100`–`w900`
/// Supported [textAlign]: `left`, `right`, `center`, `justify`, `start`, `end`
/// Supported [overflow]: `ellipsis`, `clip`, `fade`, `visible`
/// Supported [decoration]: `underline`, `lineThrough`, `overline`, `none`
class Text extends SduiNode {
  final String data;
  final double? fontSize;
  final String? color;
  final String? fontWeight;
  final String? textAlign;
  final int? maxLines;
  final String? overflow;
  final double? letterSpacing;
  final double? height;
  final String? fontFamily;
  final String? decoration;
  final String? decorationColor;

  Text(
    this.data, {
    Key? key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'widget': 'Text',
        'properties': {
          'data': data,
          if (fontSize != null) 'fontSize': fontSize,
          if (color != null) 'color': resolveColor(color),
          if (fontWeight != null) 'fontWeight': fontWeight,
          if (textAlign != null) 'textAlign': textAlign,
          if (maxLines != null) 'maxLines': maxLines,
          if (overflow != null) 'overflow': overflow,
          if (letterSpacing != null) 'letterSpacing': letterSpacing,
          if (height != null) 'height': height,
          if (fontFamily != null) 'fontFamily': fontFamily,
          if (decoration != null) 'decoration': decoration,
          if (decorationColor != null)
            'decorationColor': resolveColor(decorationColor),
        },
      };
}
