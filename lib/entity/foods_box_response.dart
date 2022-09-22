import 'package:final_project/entity/foods_box.dart';

class FoodsBoxResponse{
  List<FoodsBox> foodBox;
  int success;

  FoodsBoxResponse({required this.foodBox,required this.success});

  factory FoodsBoxResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    int success = json["success"] as int;

    List<FoodsBox> foodBox = jsonArray.map((jsonArrayObject) => FoodsBox.fromJson(jsonArrayObject)).toList();

    return FoodsBoxResponse(foodBox: foodBox, success: success);
  }
}

// FoodsBox.fromJson(jsonArrayObject))