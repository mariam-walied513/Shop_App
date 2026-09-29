
import 'package:my_new_app/features/home/data/models/slider_model.dart';

abstract class GetSlidersState {}

class GetSlidersInitState extends GetSlidersState{}
class GetSlidersSuccessState extends GetSlidersState{
  final List<SliderModel> sliders;
  GetSlidersSuccessState(this.sliders);
}
class GetSlidersErrorState extends GetSlidersState{
  final String errorMsg;
  GetSlidersErrorState(this.errorMsg);
}
class GetSlidersLoadingState extends GetSlidersState{}