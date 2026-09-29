import 'package:my_new_app/features/home/data/models/product_model.dart';



abstract class GetBestSellerState {}

class GetBestSellerInitState extends GetBestSellerState {}
class GetBestSellerLoadingState extends GetBestSellerState {}
class GetBestSellerSuccessState extends GetBestSellerState {
  final List<ProductModel> products;
  GetBestSellerSuccessState(this.products);
}
class GetBestSellerErrorState extends GetBestSellerState {
  final String errorMsg;
  GetBestSellerErrorState(this.errorMsg);
}