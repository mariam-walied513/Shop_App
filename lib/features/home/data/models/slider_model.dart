class GetSlidersResponseModel {
  bool? status;
  List<SliderModel>? sliders;

  GetSlidersResponseModel({this.status, this.sliders});

  GetSlidersResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['sliders'] != null) {
      var slidersAsList = json['sliders'] as List;
      sliders = [];
      for (var sliderMap in slidersAsList) {
        sliders!.add(SliderModel.fromJson(sliderMap));
      }
    }
  }
}

class SliderModel {
  int? id;
  String? description;
  String? imagePath;
  String? title;

  SliderModel({this.id, this.description, this.imagePath, this.title});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
    description = json['description'];
  }
}