import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_new_app/core/utils/app_paddings.dart';
import 'package:my_new_app/features/cart/presntation/cubit/cart/cart_cubit.dart';
import 'package:my_new_app/features/cart/presntation/cubit/cart/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cubit = context.read<CartCubit>();
          return ListView.separated(
            padding: AppPaddings.defaultPadding,
            itemBuilder: (context, index) {
              var product = cubit.cart[index].productModel;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -4),
                      blurRadius: 9,
                      spreadRadius: -7,
                      color: Colors.black.withValues(alpha: 0.25),
                    ),
                    BoxShadow(
                      offset: Offset(0, 6),
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
                            cubit.removeProduct(index: index);
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            product.imagePath ?? '',
                            height: 130,
                            width: 130,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name ?? ''),
                                Row(
                                  children: [
                                    Text(product.rating.toString()),
                                    SizedBox(width: 5),
                                    Icon(Icons.star),
                                  ],
                                ),
                                Text(product.price.toString()),

                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cubit.addQuantity(index: index);
                                      },
                                      icon: Icon(Icons.plus_one),
                                    ),
                                    Text(cubit.cart[index].quantity.toString()),
                                    IconButton(
                                      onPressed: cubit.cart[index].quantity > 1
                                          ? () {
                                              cubit.removeQuantity(
                                                index: index,
                                              );
                                            }
                                          : null,
                                      icon: Icon(Icons.exposure_minus_1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Divider(height: 2),
                      Row(
                        children: [
                          Text('Total Order (${cubit.cart[index].quantity}):'),
                          Spacer(),
                          Text(
                            '\$ ${cubit.cart[index].quantity * (product.price ?? 0)}):',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: cubit.cart.length,
          );
        },
      ),
    );
  }
}