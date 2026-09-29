import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchProductCard extends StatelessWidget {
  final Product product;

  const SearchProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.13),
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
            Expanded(
              flex: 6,
              child: Container(
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
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 7, 8, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 3),

                    const Text(
                      'Mens Starry Sky Printed Shirt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff555555),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      '100% Cotton Fabric',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff555555),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        ...List.generate(
                          4,
                          (index) => const Icon(
                            Icons.star,
                            size: 14,
                            color: Color(0xffffb400),
                          ),
                        ),
                        const Icon(
                          Icons.star_border,
                          size: 14,
                          color: Color(0xffD0D0D0),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.reviews,
                          style: const TextStyle(
                            fontSize: 9.5,
                            color: Color(0xffBDBDBD),
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