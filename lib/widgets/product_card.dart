import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.showFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .10),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE =================
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFFF3155),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stack) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  if (showFavorite)
                    Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                        width: 31,
                        height: 31,
                        decoration: const BoxDecoration(
                          color: Color(0xffeeeeee),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Color(0xffff3154),
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ================= DETAILS =================
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 7, 7, 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: Color(0xff555555),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      '100% Cotton Fabric',
                      style: TextStyle(
                        fontSize: 8.5,
                        color: Color(0xff555555),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          product.price,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          product.oldPrice,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xffbdbdbd),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xffffb400), size: 12),
                        const Icon(Icons.star, color: Color(0xffffb400), size: 12),
                        const Icon(Icons.star, color: Color(0xffffb400), size: 12),
                        const Icon(Icons.star, color: Color(0xffffb400), size: 12),
                        const Icon(Icons.star_border, color: Color(0xffbdbdbd), size: 12),
                        const SizedBox(width: 4),
                        Text(
                          product.reviews,
                          style: const TextStyle(
                            fontSize: 7,
                            color: Color(0xffbdbdbd),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}