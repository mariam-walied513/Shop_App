
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/home/data/repo/home_repo.dart';

import 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState>{
  GetCategoriesCubit():super(GetCategoriesInitState());

  HomeRepo repo = HomeRepo();
  fetch()async{
    emit(GetCategoriesLoadingState());
    var result = await repo.getCategories();
    result.fold(
            (errorMsg)=> emit(GetCategoriesErrorState(errorMsg)),
            (categoriesModel)=> emit(GetCategoriesSuccessState(categoriesModel.categories??[]))
    );
  }
}