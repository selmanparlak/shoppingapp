import 'package:final_project/cubit/basket_cubit.dart';
import 'package:final_project/entity/foods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Details extends StatefulWidget {
  Foods food;

  Details({required this.food});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin{
  final user = FirebaseAuth.instance.currentUser!;
  late TabController tabController;
  int selectedIndex = 0;
  var foodImage = "";
  var foodPrice = "";
  var foodName = "";
  var foodId = "";

  var foodPrices = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController= TabController(length: 5, vsync: this);
    var foods = widget.food;
    foodImage = foods.yemek_resim_adi;
    foodName =  foods.yemek_adi;
    foodPrice = foods.yemek_fiyat;
    foodPrices = int.parse(foods.yemek_fiyat);
  }
  int count = 1;

  void incrementCount(){
    setState(() {
      count++;
    });
  }
  void decrementCount(){
    if(count<2){
      return;
    }
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFfafafa),
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pushNamed(context, '/home');
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title:  Center(child: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Text("$count Adet",style: const TextStyle(fontSize: 18,color: Colors.black),),
      )),

      actions: [

          IconButton(onPressed: (){
           incrementCount();
             }, icon: const Icon(Icons.add),color: Colors.black,),
          IconButton(onPressed: (){
            decrementCount();
            }, icon: const Icon(Icons.remove),color: Colors.black,),
      ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(
                        "http://kasimadalan.pe.hu/yemekler/resimler/$foodImage"
                    ),
                  ),
                ),
              ),
              const SizedBox(height:20),
              Text("${foodPrices*count} ₺",style: const TextStyle(fontSize: 16,color: Colors.redAccent,fontWeight: FontWeight.w300 ),),
              const SizedBox(height:10),

              Text(foodName,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              /*
              TabBar(
                onTap: (index){
                  print(index);
                  if(index==0)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  Details(food: widget.food)));

                    }
                },
                controller: tabController,
                  indicatorColor: Colors.black,
                  labelColor: Colors.redAccent,
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,

                  tabs:  const [
                       Tab(
                       child: Text('Detaylar'),
                      ),

                    Tab(
                      child: Text('İçindekiler'),
                    ),
                    Tab(
                      child: Text('Besin Değerleri'),
                    ),
                    Tab(
                      child: Text('Kullanım'),
                    ),
                    Tab(
                      child: Text('Ek Bilgiler'),
                    ),
                  ],

              ),

               */

              Padding(
                padding: const EdgeInsets.only(top: 250),

                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          primary: Color(0xFFfafafa),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                          ),
                          onPressed: (){

                        context.read<BasketCubit>().addBaskets(foodName, foodImage, foodPrice,count.toString(), user.email.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 500),
                              content: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text("$foodName Sepete eklendi.",textAlign: TextAlign.center,),
                              ),
                              action: SnackBarAction(onPressed: () {  }, label: '',
                              ),
                            ),
                        );
                      },
                          child: const Text("SEPETE EKLE",style: TextStyle(color: Colors.black),)),

                ),

            ],
          ),
        ),
      ),


    );


}


