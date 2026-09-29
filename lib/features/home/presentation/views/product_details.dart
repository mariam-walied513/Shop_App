import 'package:flutter/material.dart';
import 'package:my_new_app/features/home/data/models/product_model.dart';
import 'package:my_new_app/core/utils/app_paddings.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final num unitPrice = widget.product.price ?? 100;
    final num totalPrice = unitPrice * quantity;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFAFAFAF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        widget.product.imagePath ?? '',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              widget.product.name ?? 'Mens Starry',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color:AppColors.black,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.product.description ??
                  'Vision Alta Men\'s Shoes Size (All Colours) Mens Starry Sky Printed Shirt 100% Cotton Fabric',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${totalPrice.toStringAsFixed(totalPrice is int ? 0 : 2)} \$',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                // QUANTITY
                Row(
                  children: [
                    // MINUS BUTTON
                    InkWell(
                      onTap: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '-',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // PLUS BUTTON
                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '+',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.white,
                ),
                label: const Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}