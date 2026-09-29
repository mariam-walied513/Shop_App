
import 'package:dartz/dartz.dart';
import 'package:my_new_app/core/network/api_helper.dart';
import 'package:my_new_app/core/network/end_points.dart';
import 'package:my_new_app/features/home/data/models/category_model.dart';
import 'package:my_new_app/features/home/data/models/product_model.dart';
import 'package:my_new_app/features/home/data/models/slider_model.dart';

class HomeRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, GetSlidersResponseModel>> getSliders() async {
    try {
      var response = await apiHelper.getRequest(endPoint: EndPoints.sliders);
      var jsonResponse = response.data as Map<String, dynamic>;
      return right(GetSlidersResponseModel.fromJson(jsonResponse));
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }

  Future<Either<String, GetCategoriesResponseModel>> getCategories() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.categories,
        isPrivate: true,
      );
      var jsonResponse = response.data as Map<String, dynamic>;
      return right(GetCategoriesResponseModel.fromJson(jsonResponse));
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }

  Future<Either<String, GetProductsResponseModel>> getBestSeller() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.bestSellerProducts,
        isPrivate: true,
      );
      var jsonResponse = response.data as Map<String, dynamic>;
      return right(
        GetProductsResponseModel.fromJson(
          jsonResponse,
          productsKey: 'best_seller_products',
        ),
      );
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }

  Future<Either<String, GetProductsResponseModel>> search({
    required String q,
  }) async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.search,
        isPrivate: true,
        queryParams: {'q': q},
      );
      var jsonResponse = response.data as Map<String, dynamic>;
      return right(
        GetProductsResponseModel.fromJson(
          jsonResponse,
          productsKey: 'products',
        ),
      );
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }
}