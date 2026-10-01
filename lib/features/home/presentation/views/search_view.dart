import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/features/cart/presntation/cubit/cart/cart_cubit.dart';
import 'package:my_new_app/features/home/data/models/product_model.dart';
import 'package:my_new_app/features/home/presentation/cubit/search/search_cubit.dart';
import 'package:my_new_app/features/home/presentation/cubit/search/search_state.dart';
import 'package:my_new_app/features/home/presentation/views/search_field.dart';
import 'package:my_new_app/models/product.dart';
import 'package:my_new_app/screens/product_details_screen.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  Product _toProduct(ProductModel p) {
    return Product(
      id: p.id,
      name: p.name ?? '',
      image: p.imagePath ?? '',
      rating: p.rating?.toString() ?? '0',
      reviews: '0',
      price: '\$${p.price ?? 0}',
      oldPrice: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SearchField(
                    readOnly: false,
                    controller: context.read<SearchCubit>().q,
                    onChanged: (value) => context.read<SearchCubit>().search(),
                  ),
                  SizedBox(height: 17.h),

                  Builder(
                    builder: (context) {
                      if (state is SearchLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchErrorState) {
                        return Center(child: Text(state.errorMsg));
                      } else if (state is SearchSuccessState) {
                        return Expanded(
                          child: Column(
                            children: [
                              Text('${state.products.length} items'),
                              SizedBox(height: 17.h),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    final productModel = state.products[index];
                                    final product = _toProduct(productModel);

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductDetailsScreen(
                                              product: product,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 2),
                                              color: AppColors.black
                                                  .withValues(alpha: 0.15),
                                              blurRadius: 2.r,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: Image.network(
                                                product.image,
                                                height: 200.h,
                                                errorBuilder: (_, __, ___) =>
                                                    Container(
                                                  height: 200.h,
                                                  color: Colors.grey[200],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              product.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '100% Cotton Fabric',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text('₹ ${product.price}'),
                                            Text(product.rating),
                                            SizedBox(
                                              width: 200.w,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // ✅ Add to Cart
                                                  context
                                                      .read<CartCubit>()
                                                      .addToCart(product);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        '${product.name} added to cart!',
                                                      ),
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      duration: const Duration(
                                                        seconds: 1,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppSvgs.bag,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text('Add To Cart'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.products.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}