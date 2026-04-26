/// Example DSL file demonstrating a CUSTOM widget (RatingStars) scaffolded
/// by `dart run sdui add-widget RatingStars` and exported to JSON via CLI.
///
/// Run from the example/ directory:
/// ```bash
/// dart run sdui_library:sdui add-widget RatingStars       # scaffold (already done)
/// dart run sdui_library:sdui export product_screen product_screen
/// dart run sdui_library:sdui export product_screen product_rating
/// dart run sdui_library:sdui export product_screen review_card
/// ```
///
/// Output goes to: example/exported_json/product_screen.json
// ignore: depend_on_referenced_packages
import 'package:sdui_library/sdui_dsl.dart';
import 'sdui_widgets/rating_stars/rating_stars_encoder.dart';

/// The top-level product screen — exportable as a whole.
// ignore: unused_element
final productScreen = Column(
  key: Key('product_screen'),
  children: [
    // ── Product hero ──────────────────────────────────────────────────────────
    Container(
      key: Key('product_hero'),
      height: 200,
      color: 'Colors.indigo',
      borderRadius: {'tl': 0, 'tr': 0, 'bl': 32, 'br': 32},
      child: Center(
        child: Icon(icon: 'headphones', color: 'Colors.white', size: 80),
      ),
    ),

    // ── Product info section ──────────────────────────────────────────────────
    Padding(
      padding: {'horizontal': 16, 'vertical': 16},
      child: Column(
        crossAxisAlignment: 'start',
        children: [
          Text(
            'Pro Wireless Headphones',
            fontSize: 22,
            fontWeight: 'bold',
            color: 'Colors.grey.shade900',
          ),
          Container(height: 8),
          Text(
            'Active noise cancellation · 30h battery',
            fontSize: 14,
            color: 'Colors.grey.shade600',
          ),
          Container(height: 12),

          // ✨ Custom RatingStars widget — typed DSL properties
          RatingStars(
            key: Key('product_rating'), // ← export just the stars
            rating: 4.5,
            maxStars: 5,
            label: '4.5 (2,348 reviews)',
            starColor: '#F59E0B',
            size: 22.0,
          ),

          Container(height: 16),
          Row(
            mainAxisAlignment: 'spaceBetween',
            children: [
              Text(
                '\$149.99',
                fontSize: 24,
                fontWeight: 'bold',
                color: 'Colors.indigo',
              ),
              ElevatedButton(
                label: 'Add to Cart',
                backgroundColor: 'Colors.indigo',
                labelColor: 'Colors.white',
                borderRadius: 12,
                onTap: SduiAction(
                  type: 'add_to_cart',
                  payload: {'productId': 'headphones_pro_x1', 'price': 149.99},
                ),
              ),
            ],
          ),
        ],
      ),
    ),

    // ── Review card (exportable subtree) ─────────────────────────────────────
    Padding(
      padding: {'horizontal': 16},
      child: _reviewCard(
        key: Key('review_card'), // ← export just this review
        name: 'Sarah K.',
        rating: 5.0,
        comment: 'Incredible sound quality! Worth every penny.',
        avatarColor: 'Colors.indigo',
      ),
    ),
  ],
);

// ── Helper functions ──────────────────────────────────────────────────────────

Column _reviewCard({
  Key? key,
  required String name,
  required double rating,
  required String comment,
  required String avatarColor,
}) {
  return Column(
    key: key,
    crossAxisAlignment: 'start',
    children: [
      Text(
        'Reviews',
        fontSize: 18,
        fontWeight: 'bold',
        color: 'Colors.grey.shade800',
      ),
      Container(height: 10),
      Container(
        color: 'Colors.white',
        borderRadius: 14,
        padding: {'all': 14},
        child: Column(
          crossAxisAlignment: 'start',
          children: [
            Row(
              mainAxisAlignment: 'spaceBetween',
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      color: avatarColor,
                      borderRadius: 18,
                      child: Center(
                        child: Text(
                          name[0],
                          fontSize: 16,
                          fontWeight: 'bold',
                          color: 'Colors.white',
                        ),
                      ),
                    ),
                    Container(width: 10),
                    Text(
                      name,
                      fontSize: 14,
                      fontWeight: 'w600',
                      color: 'Colors.grey.shade900',
                    ),
                  ],
                ),
                // ✨ RatingStars inside a review card — also exported to JSON
                RatingStars(
                  rating: rating,
                  maxStars: 5,
                  starColor: '#F59E0B',
                  size: 16.0,
                ),
              ],
            ),
            Container(height: 8),
            Text(comment, fontSize: 13, color: 'Colors.grey.shade600'),
          ],
        ),
      ),
    ],
  );
}
