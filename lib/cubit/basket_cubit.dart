import 'package:final_project/entity/foods_box.dart';
import 'package:final_project/repo/foodsdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketCubit extends Cubit<List<FoodsBox>> {
  BasketCubit() :super(<FoodsBox>[]);
  var fRepo = FoodsDaoRepository();

  Future<void> getBaskets(String kullanici_adi) async {
    var liste = await fRepo.getBasket(kullanici_adi);
    emit(liste);
  }

  Future<void> deleteBaskets(int sepet_yemek_id, String kullanici_adi) async {
    await fRepo.deleteBasket(sepet_yemek_id, kullanici_adi);
    await getBaskets(kullanici_adi);

  }

  Future<void> addBaskets(String yemek_adi, String yemek_resim_adi,
      String yemek_fiyat, String yemek_siparis_adet,
      String kullanici_adi) async {
    await fRepo.addBasket(
        yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet,
        kullanici_adi);

  }

}