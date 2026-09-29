import 'package:my_new_app/features/home/data/models/product_model.dart';

abstract class SearchState {}

class SearchInitState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<ProductModel> products;
  SearchSuccessState(this.products);
}

class SearchErrorState extends SearchState {
  final String errorMsg;
  SearchErrorState(this.errorMsg);
}

class SearchLoadingState extends SearchState {}