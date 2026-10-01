import 'package:flutter/material.dart';
import '../models/product.dart';

class TrendingProductCard extends StatefulWidget {
  final Product product;
  final bool showFavorite;
  final bool isFavoriteInitially;

  const TrendingProductCard({
    super.key,
    required this.product,
    this.showFavorite = true,
    this.isFavoriteInitially = false,
  });

  @override
  State<TrendingProductCard> createState() => _TrendingProductCardState();
}

class _TrendingProductCardState extends State<TrendingProductCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavoriteInitially;
  }

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
            // ================= IMAGE =================
            Expanded(
              flex: 5,  
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
                        widget.product.image,
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

                  if (widget.showFavorite)
                    Positioned(
                      top: 9,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xffE8E8E8),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xffF52D58),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ================= DETAILS =================
            Expanded(
              flex: 5,  
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 7, 8, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,   
                  children: [
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,   
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 2),   

                    const Text(
                      'Mens Starry Sky Printed Shirt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
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
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff555555),
                      ),
                    ),

                    const SizedBox(height: 3),   

                    Text(
                      widget.product.price,
                      style: const TextStyle(
                        fontSize: 12,   
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 3),   

                    Row(
                      children: [
                        ...List.generate(
                          4,
                          (index) => const Icon(
                            Icons.star,
                            size: 12,  
                            color: Color(0xffffb400),
                          ),
                        ),
                        const Icon(
                          Icons.star_border,
                          size: 12,
                          color: Color(0xffD0D0D0),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.product.reviews,
                          style: const TextStyle(
                            fontSize: 9,
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