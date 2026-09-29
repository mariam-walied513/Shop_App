
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_new_app/features/home/data/repo/home_repo.dart';
import 'package:my_new_app/features/home/presentation/cubit/get_sliders/get_sliders_state.dart';

class GetSlidersCubit extends Cubit<GetSlidersState>{
  GetSlidersCubit():super(GetSlidersInitState());

  HomeRepo repo = HomeRepo();
  fetch()async{
    emit(GetSlidersLoadingState());
    var result = await repo.getSliders();
    result.fold(
        (errorMsg)=> emit(GetSlidersErrorState(errorMsg)),
        (slidersModel)=> emit(GetSlidersSuccessState(slidersModel.sliders??[]))
    );
  }
}