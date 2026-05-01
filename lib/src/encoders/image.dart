import 'sdui_key.dart';
import 'sdui_node.dart';

/// DSL node for an [Image] widget (network images).
///
/// ### Usage
/// ```dart
/// Image(
///   src: 'https://example.com/photo.jpg',
///   key: Key('hero_image'),
///   width: 300,
///   height: 200,
///   fit: 'cover',
///   borderRadius: 12,
/// )
/// ```
///
/// Supported [fit] values: `fill`, `contain`, `cover`, `fitWidth`,
/// `fitHeight`, `none`, `scaleDown`
class Image extends SduiNode {
  /// Network URL of the image.
  final String src;
  final double? width;
  final double? height;

  /// Box fit string: `'cover'`, `'contain'`, `'fill'`, etc.
  final String? fit;

  /// Border radius: a number (uniform) or a map with `tl` / `tr` / `bl` / `br`.
  final dynamic borderRadius;

  Image({
    Key? key,
    required this.src,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
    'widget': 'Image',
    'properties': {
      'src': src,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (fit != null) 'fit': fit,
      if (borderRadius != null) 'borderRadius': borderRadius,
    },
  };
}
