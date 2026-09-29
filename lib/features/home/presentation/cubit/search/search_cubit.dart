import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/home/data/repo/home_repo.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitState());

  var q = TextEditingController();
  HomeRepo repo = HomeRepo();
  Future<void> search() async {
    if (q.text.isEmpty) {
      emit(SearchSuccessState([]));
    }
    emit(SearchLoadingState());
    var result = await repo.search(q: q.text);
    result.fold(
      (errorMsg) => emit(SearchErrorState(errorMsg)),
      (productsResponse) =>
          emit(SearchSuccessState(productsResponse.products ?? [])),
    );
  }
}