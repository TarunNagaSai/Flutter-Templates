import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:like_button/like_button.dart';

class CardsSliver extends StatelessWidget {
  const CardsSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Product3DCard(
          modelUrl: 'assets/3d_models/medium-couch-877.glb',
          title: 'Premium Couch',
          price: 500,
        ),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.onAddToCart,
    this.onToggleWishlist,
  });

  final String imageUrl;
  final String title;
  final double price;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleWishlist;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  bool isPressed = false;

  late final AnimationController _pressController;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_pressController);
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => isFavorite = !isFavorite);
    widget.onToggleWishlist?.call();
  }

  void _onTapDown(_) {
    _pressController.forward();
    setState(() => isPressed = true);
  }

  void _onTapUp(_) {
    _pressController.reverse();
    setState(() => isPressed = false);
  }

  void _onTapCancel() {
    _pressController.reverse();
    setState(() => isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        return Transform.scale(scale: _scale.value, child: child);
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isPressed
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          clipBehavior: .antiAlias,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // Image + wishlist button
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(widget.imageUrl, fit: BoxFit.cover),
                    Positioned(top: 8, right: 8, child: LikeButton()),
                  ],
                ),
              ),

              // Title + price + add-to-cart
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '₹${widget.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: widget.onAddToCart,
                          icon: const Icon(Icons.add_shopping_cart, size: 18),
                          label: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Elevated Button for a product card
class ElevatedProductCard extends StatelessWidget {
  const ElevatedProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Card pressed action
        },

        /// splash radius should match border radius
        borderRadius: BorderRadius.circular(12),
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.black87,
        //   elevation: 4,
        //   padding: const EdgeInsets.all(16),
        //   minimumSize: const Size(double.infinity, 120),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        //   shadowColor: Colors.black.withOpacity(0.1),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://assets.turbologo.com/blog/en/2021/09/10093610/photo-camera-958x575.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Title',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('₹1,299', style: TextTheme.of(context).headlineSmall),
                    const SizedBox(height: 8),
                    Text('Short description here...'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 3d Model Product Card
class Product3DCard extends StatefulWidget {
  const Product3DCard({
    super.key,
    required this.modelUrl,
    required this.title,
    required this.price,
  });

  final String modelUrl;
  final String title;
  final double price;

  @override
  State<Product3DCard> createState() => _Product3DCardState();
}

class _Product3DCardState extends State<Product3DCard> {
  late Flutter3DController controller;
  bool isModelLoaded = false;
  String? currentAnimation;

  @override
  void initState() {
    super.initState();
    controller = Flutter3DController();
    // Listen for model load
    controller.onModelLoaded.addListener(() {
      if (controller.onModelLoaded.value) {
        setState(() => isModelLoaded = true);
        controller.playAnimation(); // Auto play first animation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card.filled(
        color: Colors.grey.shade200,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Flutter3DViewer(
                      controller: controller,
                      activeGestureInterceptor: true,
                      progressBarColor: Colors.grey,
                      enableTouch: true, // User can rotate
                      src: widget.modelUrl,
                    ),
                  ),
                ),
                Positioned(top: 8, right: 0, child: LikeButton()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: .topLeft,
                    child: Icon(Icons.threed_rotation_rounded),
                  ),
                ),

                Align(
                  alignment: .bottomCenter,
                  child: Column(
                    mainAxisAlignment: .end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          crossAxisAlignment: .end,
                          children: [
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Icon(Icons.star_rate, color: Colors.amber.shade600),
                            Text(
                              '4.8',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 2.0, left: 8.0),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              '₹${widget.price.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            IconButton.filled(
                              focusColor: Colors.black,
                              highlightColor: Colors.black,
                              hoverColor: Colors.black,
                              color: Colors.white,
                              tooltip: "Details",
                              onPressed: () {
                                // Add to cart action
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
