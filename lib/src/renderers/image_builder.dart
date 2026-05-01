import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds an [Image] widget from a JSON definition.
/// Currently supports network images via [Image.network].
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Image",
///   "properties": {
///     "src": "https://example.com/photo.jpg",
///     "width": 200,
///     "height": 150,
///     "fit": "cover",
///     "borderRadius": 12
///   }
/// }
/// ```
class ImageBuilder {
  ImageBuilder._();

  static Widget fromJson(Map<String, dynamic> json) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final src = props['src'] as String?;
    final width = toDouble(props['width']);
    final height = toDouble(props['height']);
    final fit = parseBoxFit(props['fit'] as String?);
    final borderRadius = parseBorderRadius(props['borderRadius']);

    if (src == null || src.isEmpty) {
      return _placeholder(width, height);
    }

    final imageWidget = Image.network(
      src,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _placeholder(width, height),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );

    if (props['borderRadius'] != null) {
      return ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }

    return imageWidget;
  }

  static Widget _placeholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFEEEEEE),
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Color(0xFF9E9E9E),
          size: 32,
        ),
      ),
    );
  }
}
