import 'package:final_project/cubit/basket_cubit.dart';
import 'package:final_project/entity/foods_box.dart';
import 'package:final_project/repo/foodsdao_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Basket extends StatefulWidget {
   const Basket({Key? key}) : super(key: key);


  @override
  State<Basket> createState() => _BasketState();


}

class _BasketState extends State<Basket> {
  final user = FirebaseAuth.instance.currentUser!;
  int selectedIndex = 0;
  int count = 0;

 var repo = FoodsDaoRepository();
  Future<List<FoodsBox>> get(String kullanici_adi) async {
    return  repo.getBasket(kullanici_adi);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    //  context.read<BasketCubit>().getBaskets("deneme");
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title:   const Center(child: Text("Sepetim",style: TextStyle(color: Colors.black),)),

          backgroundColor: const Color(0xFFfafafa),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<FoodsBox>>(
          future: get(user.email.toString()),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var FoodsList = snapshot.data;
              return ListView.builder(
                itemCount: FoodsList!.length,
                itemBuilder: (context,index) {
                  var foods = FoodsList[index];
                  var count = int.parse(foods.yemek_siparis_adet);
                  int price = int.parse(foods.yemek_fiyat);

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              image: DecorationImage(
                                fit: BoxFit.scaleDown,
                                image: NetworkImage(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${foods.yemek_resim_adi}"
                                ),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10),

                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child:  Center(child: Text(foods.yemek_siparis_adet)),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(foods.yemek_adi,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                          const Spacer(),
                          Column(
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  context.read<BasketCubit>().deleteBaskets(int.parse(foods.sepet_yemek_id), user.email.toString()).then((value) => (){
                                    context.read<BasketCubit>().getBaskets(user.email.toString());
                                  });
                                });

                              }, icon: const Icon(Icons.remove)),
                              Text("${count*price}₺",style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),

                            ],
                          ),
                        ],
                      ),
                    ),

                  );
                },
              );

            }

            else {
              return  const Center(
              );
            }
          },

        ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Sepetim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.red[300],
        onTap: (index){
    switch(index)
    {
    case 0:
    Navigator.pushNamed(context, "/home");
    break;
    case 1:
    Navigator.pushNamed(context, "/basket");
    break;
    case 2:
    Navigator.pushNamed(context, "/profile");

    }
    }
      ),
    );

  }


}
