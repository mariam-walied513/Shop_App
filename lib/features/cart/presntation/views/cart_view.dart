import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_new_app/core/utils/app_paddings.dart';
import 'package:my_new_app/features/cart/presntation/cubit/cart/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocBuilder<CartCubit, List<CartItem>>(
          builder: (context, items) {
            final cubit = context.read<CartCubit>();

            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.separated(
              padding: AppPaddings.defaultPadding,
              itemBuilder: (context, index) {
                final item = items[index];
                final product = item.product;

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, -4),
                        blurRadius: 9,
                        spreadRadius: -7,
                        color: Colors.black.withValues(alpha: 0.25),
                      ),
                      BoxShadow(
                        offset: const Offset(0, 6),
                        blurRadius: 14,
                        spreadRadius: -8,
                        color: Colors.black.withValues(alpha: 0.25),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              cubit.removeFromCart(product);
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                        Row(
                          children: [
                            Image.network(
                              product.image,
                              height: 130,
                              width: 130,
                              errorBuilder: (_, __, ___) => Container(
                                height: 130,
                                width: 130,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name),
                                  Row(
                                    children: [
                                      Text(product.rating),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.star, size: 16),
                                    ],
                                  ),
                                  Text(product.price),

                                 
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cubit.addQuantity(index: index);
                                        },
                                        icon: const Icon(Icons.plus_one),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: item.quantity > 1
                                            ? () {
                                                cubit.removeQuantity(
                                                  index: index,
                                                );
                                              }
                                            : null,
                                        icon: const Icon(
                                          Icons.exposure_minus_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 2),
                        Row(
                          children: [
                            Text('Total Order (${item.quantity}):'),
                            const Spacer(),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: items.length,
            );
          },
        ),
      ),
    );
  }
}