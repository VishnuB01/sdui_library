import 'package:flutter/material.dart';
import '../core/sdui_utils.dart';

/// Builds an [Icon] widget from a JSON definition.
///
/// ### Supported JSON
/// ```json
/// {
///   "widget": "Icon",
///   "properties": {
///     "icon": "star",
///     "color": "#FFD700",
///     "size": 32
///   }
/// }
/// ```
///
/// Supported icon names are a curated subset of [Icons].
/// Unknown icon names fall back to [Icons.widgets].
class IconBuilder {
  IconBuilder._();

  static Widget fromJson(Map<String, dynamic> json) {
    final props = (json['properties'] as Map<String, dynamic>?) ?? {};

    final iconName = props['icon'] as String? ?? 'widgets';
    final color = props['color'] != null ? parseColor(props['color']) : null;
    final size = toDouble(props['size']);

    return Icon(
      _resolveIcon(iconName),
      color: color,
      size: size,
    );
  }

  /// Maps icon name strings to [IconData].
  static IconData _resolveIcon(String name) {
    const icons = <String, IconData>{
      // Navigation
      'home': Icons.home,
      'back': Icons.arrow_back,
      'forward': Icons.arrow_forward,
      'menu': Icons.menu,
      'close': Icons.close,
      'search': Icons.search,
      'settings': Icons.settings,
      // Actions
      'add': Icons.add,
      'edit': Icons.edit,
      'delete': Icons.delete,
      'share': Icons.share,
      'download': Icons.download,
      'upload': Icons.upload,
      'refresh': Icons.refresh,
      'filter': Icons.filter_list,
      'sort': Icons.sort,
      // Status
      'check': Icons.check,
      'check_circle': Icons.check_circle,
      'error': Icons.error,
      'warning': Icons.warning,
      'info': Icons.info,
      // Media
      'play': Icons.play_arrow,
      'pause': Icons.pause,
      'stop': Icons.stop,
      'camera': Icons.camera_alt,
      'image': Icons.image,
      'video': Icons.videocam,
      'mic': Icons.mic,
      // Communication
      'email': Icons.email,
      'phone': Icons.phone,
      'chat': Icons.chat,
      'notifications': Icons.notifications,
      // Content
      'star': Icons.star,
      'star_border': Icons.star_border,
      'favorite': Icons.favorite,
      'favorite_border': Icons.favorite_border,
      'bookmark': Icons.bookmark,
      'bookmark_border': Icons.bookmark_border,
      'person': Icons.person,
      'group': Icons.group,
      'location': Icons.location_on,
      'calendar': Icons.calendar_today,
      'clock': Icons.access_time,
      'cart': Icons.shopping_cart,
      'bag': Icons.shopping_bag,
      'payment': Icons.payment,
      'wallet': Icons.account_balance_wallet,
      'lock': Icons.lock,
      'unlock': Icons.lock_open,
      'visibility': Icons.visibility,
      'visibility_off': Icons.visibility_off,
      'thumb_up': Icons.thumb_up,
      'thumb_down': Icons.thumb_down,
      'link': Icons.link,
      'attach': Icons.attach_file,
      'copy': Icons.copy,
      'paste': Icons.paste,
      'print': Icons.print,
      'qr_code': Icons.qr_code,
      'bar_chart': Icons.bar_chart,
      'pie_chart': Icons.pie_chart,
      'trending_up': Icons.trending_up,
      'trending_down': Icons.trending_down,
      'widgets': Icons.widgets,
    };

    return icons[name] ?? Icons.widgets;
  }
}
