import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../data/sample_products.dart';
import '../constants/colors.dart';
import '../features/cart/cubit/cart_cubit.dart';
import 'place_order_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 21,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              const Text(
                "Shopping List",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

             
              BlocBuilder<CartCubit, List<CartItem>>(
                builder: (context, items) {
                  if (items.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: CartProductCard(
                              product: item.product,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),

           
              const CartProductCard(product: womenProduct),

              const SizedBox(height: 14),

              const CartProductCard(product: jacketProduct),

              const SizedBox(height: 14),

              const OrderSummary(),

              const SizedBox(height: 50),

              // ============ CHECKOUT BUTTON ============
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlaceOrderScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CART PRODUCT CARD
// ============================================================
class CartProductCard extends StatelessWidget {
  final Product product;

  const CartProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  product.image,
                  width: 117,
                  height: 113,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      width: 117,
                      height: 113,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryPink,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stack) {
                    return Container(
                      width: 117,
                      height: 113,
                      color: const Color(0xFFF1F1F1),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          product.rating,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFB800),
                          size: 15,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          product.price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.oldPrice,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 9),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        quantityButton(
                          icon: Icons.remove,
                          color: lightPink,
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          "1",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 14),
                        quantityButton(
                          icon: Icons.add,
                          color: primaryPink,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Divider(height: 1, color: borderColor),

          SizedBox(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Order (1) :",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityButton({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}

// ============================================================
// ORDER SUMMARY
// ============================================================
class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 0),
      child: Column(
        children: [
          summaryRow("Subtotal", "\$ 79.00"),
          const SizedBox(height: 10),
          summaryRow("Tax and Fees", "\$ 3.00"),
          const SizedBox(height: 10),
          summaryRow("Delivery Fee", "\$ 2.00"),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Colors.black26),
          const SizedBox(height: 14),
          summaryRow("Order Total", "\$ 84.00", isTotal: true),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: FontWeight.w500,
            color: isTotal ? primaryPink : Colors.black,
          ),
        ),
      ],
    );
  }
}