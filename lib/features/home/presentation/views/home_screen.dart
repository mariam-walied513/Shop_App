import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_new_app/core/cache/cache_helper.dart';
import 'package:my_new_app/core/cache/cache_keys.dart';
import 'package:my_new_app/core/helper/my_navigator.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/core/utils/app_paddings.dart';

import 'package:my_new_app/features/auth/presentation/views/login_screen.dart';

import 'package:my_new_app/features/home/data/models/category_model.dart';
import 'package:my_new_app/features/home/data/models/product_model.dart';

import 'package:my_new_app/features/home/presentation/cubit/get_best_seller/get_best_seller_cubit.dart';
import 'package:my_new_app/features/home/presentation/cubit/get_best_seller/get_best_seller_state.dart';

import 'package:my_new_app/features/home/presentation/cubit/get_catrgories/get_categories_cubit.dart';
import 'package:my_new_app/features/home/presentation/cubit/get_catrgories/get_categories_state.dart';

import 'package:my_new_app/features/home/presentation/cubit/get_sliders/get_sliders_cubit.dart';
import 'package:my_new_app/features/home/presentation/cubit/get_sliders/get_sliders_state.dart';

import 'package:my_new_app/features/home/presentation/views/search_field.dart';

import 'package:my_new_app/screens/search_screen.dart';
import 'package:my_new_app/models/product.dart';
import 'package:my_new_app/screens/product_details_screen.dart';

import 'package:my_new_app/features/profile/presentation/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryModel? selectedCategory;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      _buildItemsContent(),
      const ProfileView(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetSlidersCubit()..fetch(),
        ),
        BlocProvider(
          create: (context) => GetCategoriesCubit()..fetch(),
        ),
        BlocProvider(
          create: (context) => GetBestSellerCubit()..fetch(),
        ),
      ],
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const Spacer(),
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await CacheHelper.removeValue(
                    key: CacheKeys.accessToken,
                  );
                  await CacheHelper.removeValue(
                    key: CacheKeys.refreshToken,
                  );
                  MyNavigator.goTo(
                    context,
                    toPage: const LoginScreen(),
                    type: NavigatorType.pushAndRemoveUntil,
                  );
                },
              ),
            ],
          ),
        ),

        appBar: _currentIndex == 0
            ? AppBar(
                title: const Text('Home'),
              )
            : null,

        body: pages[_currentIndex],

        floatingActionButton: _currentIndex == 0
            ? Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppSvgs.bag,
                    width: 26,
                    height: 26,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              )
            : null,

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppSvgs.home),
                activeIcon: Icon(Icons.home, color: AppColors.primary),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppSvgs.cart),
                activeIcon: SvgPicture.asset(AppSvgs.bag),
                label: 'Items',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppSvgs.profile2),
                activeIcon: SvgPicture.asset(AppSvgs.profile2),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HOME CONTENT
  // ============================================================
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppPaddings.defaultPadding,
            child: SearchField(
              readOnly: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          _buildCategories(),

          const SizedBox(height: 20),

          if (selectedCategory == null) ...[
            _buildSliders(),
            const SizedBox(height: 20),
          ],

          _buildProductsTitle(),

          const SizedBox(height: 10),

          Padding(
            padding: AppPaddings.defaultPadding,
            child: _buildProductsSection(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ITEMS CONTENT (Logo + Categories + Products)
  // ============================================================
  Widget _buildItemsContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),   
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppSvgs.logo,
                  width: 35,   
                  height: 35,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Stylish',
                  style: TextStyle(
                    fontSize: 20,   
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          _buildCategories(),

          const SizedBox(height: 20),

          Padding(
            padding: AppPaddings.defaultPadding,
            child: const Text(
              'Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: AppPaddings.defaultPadding,
            child: _buildProductsSection(firstProductFavorite: true),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORIES
  // ============================================================
  Widget _buildCategories() {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetCategoriesErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        } else if (state is GetCategoriesSuccessState) {
          return SizedBox(
            height: 110,
            child: ListView.separated(
              padding: AppPaddings.defaultPadding,
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 20);
              },
              itemBuilder: (context, index) {
                final category = state.categories[index];
                final isSelected = selectedCategory?.id == category.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedCategory?.id == category.id) {
                        selectedCategory = null;
                      } else {
                        selectedCategory = category;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            category.imagePath ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.title ?? '',
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  // ============================================================
  // SLIDERS
  // ============================================================
  Widget _buildSliders() {
    return BlocBuilder<GetSlidersCubit, GetSlidersState>(
      builder: (context, state) {
        if (state is GetSlidersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSlidersErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        } else if (state is GetSlidersSuccessState) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              viewportFraction: 0.9,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
            ),
            items: state.sliders.map((sliderModel) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    padding: AppPaddings.defaultPadding,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          sliderModel.imagePath ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      sliderModel.title ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
        return const SizedBox();
      },
    );
  }

  // ============================================================
  // PRODUCTS TITLE
  // ============================================================
  Widget _buildProductsTitle() {
    return Padding(
      padding: AppPaddings.defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedCategory == null
                ? 'Best Seller Products'
                : '${selectedCategory!.title} Products',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (selectedCategory != null)
            TextButton(
              onPressed: () {
                setState(() {
                  selectedCategory = null;
                });
              },
              child: const Text('Clear Filter'),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCTS SECTION
  // ============================================================
  Widget _buildProductsSection({bool firstProductFavorite = false}) {
    if (selectedCategory != null) {
      final products = selectedCategory!.products ?? [];

      if (products.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'No products available in this category.',
            ),
          ),
        );
      }

      return _buildProductsGrid(
        products,
        firstProductFavorite: firstProductFavorite,
      );
    }

    return BlocBuilder<GetBestSellerCubit, GetBestSellerState>(
      builder: (context, state) {
        if (state is GetBestSellerLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetBestSellerSuccessState) {
          return _buildProductsGrid(
            state.products,
            firstProductFavorite: firstProductFavorite,
          );
        }
        return const SizedBox();
      },
    );
  }

  // ============================================================
  // PRODUCTS GRID
  // ============================================================
  Widget _buildProductsGrid(
    List<ProductModel> products, {
    bool firstProductFavorite = false,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productModel = products[index];

        return GestureDetector(
          onTap: () {
            final product = Product(
              id: productModel.id,
              name: productModel.name ?? '',
              image: productModel.imagePath ?? '',
              rating: productModel.rating?.toString() ?? '0',
              reviews: '0',
              price: '\$${productModel.price ?? 0}',
              oldPrice: '',
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.network(
                            productModel.imagePath ?? '',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) {
                              return const Icon(
                                Icons.image_not_supported,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        productModel.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        productModel.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'EGP ${productModel.price ?? 0.0}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                if (firstProductFavorite && index == 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: Color(0xffF52D58),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}