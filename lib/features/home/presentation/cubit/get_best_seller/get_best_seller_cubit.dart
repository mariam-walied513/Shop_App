import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/home/data/repo/home_repo.dart';
import 'get_best_seller_state.dart';

class GetBestSellerCubit extends Cubit<GetBestSellerState> {
  GetBestSellerCubit() : super(GetBestSellerInitState());

  HomeRepo repo = HomeRepo();

  fetch() async {
    emit(GetBestSellerLoadingState());
    var result = await repo.getBestSeller();
    result.fold(
      (errorMsg) => emit(GetBestSellerErrorState(errorMsg)),
      (productsModel) => emit(GetBestSellerSuccessState(productsModel.products ?? [])),
    );
  }
}