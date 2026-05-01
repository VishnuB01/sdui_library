import 'color_resolver.dart';
import 'sdui_action.dart';
import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for button widgets.
///
/// Supports [ElevatedButton], [TextButton], and [OutlinedButton] —
/// each is a separate class but all share the same serialisation logic.
///
/// ### ElevatedButton usage
/// ```dart
/// ElevatedButton(
///   key: Key('cta_button'),
///   label: 'Get Started',
///   backgroundColor: 'Colors.indigo',
///   labelColor: 'Colors.white',
///   fontSize: 16,
///   fontWeight: 'bold',
///   borderRadius: 12,
///   padding: {'horizontal': 24, 'vertical': 14},
///   icon: Icon(icon: 'star'),
///   onTap: SduiAction(type: 'navigate', payload: {'route': '/home'}),
/// )
/// ```
///
/// ### TextButton usage
/// ```dart
/// TextButton(label: 'Skip', onTap: SduiAction(type: 'dismiss'))
/// ```
///
/// ### OutlinedButton usage
/// ```dart
/// OutlinedButton(
///   label: 'Learn More',
///   borderColor: 'Colors.indigo',
///   borderWidth: 2,
///   labelColor: 'Colors.indigo',
///   onTap: SduiAction(type: 'navigate', payload: {'route': '/detail'}),
/// )
/// ```

abstract class _ButtonBase extends SduiNode {
  final String _buttonType;
  final String label;
  final String? labelColor;
  final String? backgroundColor;
  final String? borderColor;
  final double? borderWidth;
  final dynamic borderRadius;
  final double? fontSize;
  final String? fontWeight;
  final dynamic padding;
  final SduiNode? icon;
  final SduiAction? onTap;

  _ButtonBase(
    this._buttonType, {
    Key? key,
    required this.label,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
    'widget': _buttonType,
    'properties': {
      'label': label,
      if (labelColor != null) 'labelColor': resolveColor(labelColor),
      if (backgroundColor != null)
        'backgroundColor': resolveColor(backgroundColor),
      if (borderColor != null) 'borderColor': resolveColor(borderColor),
      if (borderWidth != null) 'borderWidth': borderWidth,
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (fontSize != null) 'fontSize': fontSize,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (padding != null) 'padding': padding,
    },
    if (icon != null) 'icon': icon!.toJson(),
    if (onTap != null) 'onTap': onTap!.toJson(),
  };
}

/// A filled elevated button. See [_ButtonBase] for all properties.
class ElevatedButton extends _ButtonBase {
  ElevatedButton({
    Key? key,
    required String label,
    String? labelColor,
    String? backgroundColor,
    dynamic borderRadius,
    double? fontSize,
    String? fontWeight,
    dynamic padding,
    SduiNode? icon,
    SduiAction? onTap,
  }) : super(
         'ElevatedButton',
         key: key,
         label: label,
         labelColor: labelColor,
         backgroundColor: backgroundColor,
         borderRadius: borderRadius,
         fontSize: fontSize,
         fontWeight: fontWeight,
         padding: padding,
         icon: icon,
         onTap: onTap,
       );
}

/// A flat text button. See [_ButtonBase] for all properties.
class TextButton extends _ButtonBase {
  TextButton({
    Key? key,
    required String label,
    String? labelColor,
    dynamic borderRadius,
    double? fontSize,
    String? fontWeight,
    dynamic padding,
    SduiNode? icon,
    SduiAction? onTap,
  }) : super(
         'TextButton',
         key: key,
         label: label,
         labelColor: labelColor,
         borderRadius: borderRadius,
         fontSize: fontSize,
         fontWeight: fontWeight,
         padding: padding,
         icon: icon,
         onTap: onTap,
       );
}

/// An outlined (bordered) button. See [_ButtonBase] for all properties.
class OutlinedButton extends _ButtonBase {
  OutlinedButton({
    Key? key,
    required String label,
    String? labelColor,
    String? borderColor,
    double? borderWidth,
    dynamic borderRadius,
    double? fontSize,
    String? fontWeight,
    dynamic padding,
    SduiNode? icon,
    SduiAction? onTap,
  }) : super(
         'OutlinedButton',
         key: key,
         label: label,
         labelColor: labelColor,
         borderColor: borderColor,
         borderWidth: borderWidth,
         borderRadius: borderRadius,
         fontSize: fontSize,
         fontWeight: fontWeight,
         padding: padding,
         icon: icon,
         onTap: onTap,
       );
}
