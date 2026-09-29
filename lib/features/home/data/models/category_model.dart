import 'package:my_new_app/features/home/data/models/product_model.dart';

class GetCategoriesResponseModel{
  bool? status;
  List<CategoryModel>? categories;

  GetCategoriesResponseModel({this.status, this.categories});
  GetCategoriesResponseModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    if(json['categories'] != null){
      var c = json['categories'] as List;
      categories = [];
      for(var category in c){
        categories!.add(CategoryModel.fromJson(category));
      }
    }
  }
}

class CategoryModel {
  int? id;
  String? description;
  String? imagePath;
  String? title;
  List<ProductModel>? products;

  CategoryModel({this.id, this.description, this.imagePath, this.title, this.products});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
    description = json['description'];
    if(json['products'] != null){
      var p = json['products'] as List;
      products = [];
      for(var product in p){
        products!.add(ProductModel.fromJson(product));
      }

    }
  }
}