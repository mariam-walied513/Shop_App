import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/cart/data/models/cart_item_model.dart';
import 'package:my_new_app/features/cart/presntation/cubit/cart/cart_state.dart';
import 'package:my_new_app/features/home/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState());
  List<CartItemModel> cart = [];

  void addProduct({required ProductModel product, int quantity = 1}) {
    cart.add(CartItemModel(productModel: product, quantity: quantity));
    emit(CartAddState());
  }

  void removeProduct({required int index}) {
    cart.removeAt(index);
    emit(CartRemoveState());
  }

  void addQuantity({required int index}) {
    cart[index].quantity += 1;
    emit(CartAddState());
  }

  void removeQuantity({required int index}) {
    if (cart[index].quantity > 1) {
      cart[index].quantity -= 1;
      emit(CartRemoveState());
    }
  }

  void clearCart() {
    cart = [];
    emit(CartClearState());
  }
}