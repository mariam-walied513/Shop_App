import 'package:my_new_app/features/home/data/models/category_model.dart';

abstract class GetCategoriesState {}

class GetCategoriesInitState extends GetCategoriesState{}
class GetCategoriesSuccessState extends GetCategoriesState{
  final List<CategoryModel> categories;
  GetCategoriesSuccessState(this.categories);
}
class GetCategoriesErrorState extends GetCategoriesState{
  final String errorMsg;
  GetCategoriesErrorState(this.errorMsg);
}
class GetCategoriesLoadingState extends GetCategoriesState{}