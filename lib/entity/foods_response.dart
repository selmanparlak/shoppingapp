import 'package:final_project/entity/foods.dart';

class FoodsResponse{
  List<Foods> food;
  int success;

  FoodsResponse({required this.food,required this.success});

  factory FoodsResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["yemekler"] as List;
   List<Foods> food = jsonArray.map((jsonArrayObject) => Foods.fromJson(jsonArrayObject)).toList();
    int success = json["success"] as int;
    return FoodsResponse(food: food, success: success);
  }
}