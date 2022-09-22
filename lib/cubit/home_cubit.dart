import 'package:final_project/entity/foods.dart';
import 'package:final_project/repo/foodsdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<List<Foods>>{
  HomeCubit():super(<Foods>[]);
  var fRepo = FoodsDaoRepository();

  Future<void> getFoods() async {
    var list = await fRepo.allGetFood();
    emit(list);
  }
  }