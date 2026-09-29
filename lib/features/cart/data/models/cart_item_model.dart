import 'package:my_new_app/features/home/data/models/product_model.dart';

class CartItemModel {
  ProductModel productModel;
  int quantity;

  CartItemModel({required this.productModel, this.quantity = 1});
}