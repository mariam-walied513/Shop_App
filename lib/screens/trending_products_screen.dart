import 'package:flutter/material.dart';
import '../data/search_products.dart';
import '../models/product.dart';
import '../widgets/trending_product_card.dart';

class TrendingProductsScreen extends StatelessWidget {
  const TrendingProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      searchProduct1,
      searchProduct2,
      searchProduct1,
      searchProduct2,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Favorites',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                ],
              ),
            ),

            // ================= PRODUCTS =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 15),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return TrendingProductCard(
                      product: products[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}