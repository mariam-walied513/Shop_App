import 'package:flutter/material.dart';
import '../data/search_products.dart';
import '../models/product.dart';
import '../widgets/trending_product_card.dart';
import 'trending_products_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      searchProduct1,
      searchProduct2,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 21,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: const Color(0xfff2f2f2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 18,
                      color: Color(0xffc5c5c5),
                    ),
                    hintText: 'Search any Product...',
                    hintStyle: TextStyle(
                      fontSize: 11,
                      color: Color(0xffc5c5c5),
                    ),
                    contentPadding: EdgeInsets.only(top: 1),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrendingProductsScreen(),
                    ),
                  );
                },
                child: const Text(
                  '2 Teams',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TrendingProductCard(
                        product: products[0],
                        showFavorite: false,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: TrendingProductCard(
                        product: products[1],
                        showFavorite: false,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}