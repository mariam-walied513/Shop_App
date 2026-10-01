import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/trending_product_card.dart';
import '../features/home/data/repo/home_repo.dart';
import '../features/home/data/models/product_model.dart';
import 'product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final HomeRepo _repo = HomeRepo();

  bool _isLoading = false;
  String _errorMsg = '';
  List<ProductModel> _results = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _errorMsg = '';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    final result = await _repo.search(q: query);

    result.fold(
      (error) {
        setState(() {
          _isLoading = false;
          _errorMsg = error;
          _results = [];
        });
      },
      (response) {
        setState(() {
          _isLoading = false;
          _results = response.products ?? [];
        });
      },
    );
  }

  Product _toProduct(ProductModel p) {
    return Product(
      id: p.id,
      name: p.name ?? '',
      image: p.imagePath ?? '',
      rating: p.rating?.toString() ?? '0',
      reviews: '0',
      price: '\$ ${p.price ?? 0}',
      oldPrice: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ============ HEADER ============
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
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

              // ============ SEARCH BOX ============
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
                child: TextField(
                  controller: _controller,
                  onChanged: _search,
                  decoration: const InputDecoration(
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

              // ============ RESULTS COUNT ============
              Text(
                '${_results.length} Items',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              // ============ RESULTS ============
              Expanded(
                child: _buildResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFF3655),
        ),
      );
    }

    if (_errorMsg.isNotEmpty) {
      return Center(
        child: Text(
          _errorMsg,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_results.isEmpty) {
      return const Center(
        child: Text(
          'Search for products...',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xffc5c5c5),
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final productModel = _results[index];
        final product = _toProduct(productModel);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
          child: TrendingProductCard(
            product: product,
            showFavorite: false,
          ),
        );
      },
    );
  }
}