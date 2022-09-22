import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:final_project/entity/foods.dart';
import 'package:final_project/entity/foods_box.dart';
import 'package:final_project/entity/foods_response.dart';
import '../entity/foods_box_response.dart';
import 'package:http/http.dart' as http;

class FoodsDaoRepository {
  List<Foods> parseFoodsResponse(String response){
    /* var jsonVeri = json.decode(cevap);
    var kisilerCevap =KisilerCevap.fromJson(jsonVeri);
    return kisilerCevap.kisiler;
    */
    return FoodsResponse.fromJson(json.decode(response)).food;
  }

  List<FoodsBox> parseFoodsBoxResponse(String response){
    /*
      var jsonVeri = json.decode(response);
      var foodboxresponse =FoodsBoxResponse.fromJson(jsonVeri);
      print(foodboxresponse.foodBox.length);
      return foodboxresponse.foodBox;

     */
    return FoodsBoxResponse.fromJson(json.decode(response)).foodBox;

  }

  Future<List<Foods>> allGetFood() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().post(url);
    return parseFoodsResponse(response.data.toString());
  }
  Future<List<FoodsBox>> getBasket(String kullanici_adi) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi":kullanici_adi};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("sepet: ${response.data.toString()}");

    return parseFoodsBoxResponse(response.data.toString());
/*
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var data = {"kullanici_adi":kullanici_adi};
    var response = await https.post(url,body:data);
    return parseFoodsBoxResponse(response.body);

 */
  }

  Future<void> addBasket(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {"yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi};
    var response = await Dio().post(url,data: FormData.fromMap(data));
    print("sepete yemek ekle: ${response.data.toString()}");
  }

  Future<void>  deleteBasket(int sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi};
    var response = await Dio().post(url,data:FormData.fromMap(data));
    print("sepet sil: ${response.data.toString()}");
  }

}