import 'package:final_project/cubit/home_cubit.dart';
import 'package:final_project/entity/foods.dart';
import 'package:final_project/views/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late TabController tabController;
  int selectedIndex = 0;
  bool is_clicked = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController= TabController(length: 5, vsync: this);
    context.read<HomeCubit>().getFoods();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
          title: const Center(child: Text("Anasayfa",style: TextStyle(color: Colors.black),)),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFfafafa),
        bottom: TabBar(
          onTap: (index){
            print(index);
            },
          controller: tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.redAccent,
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          tabs:  const [
          Tab(
            child: Text('Kahvaltılık'),
          ),
          Tab(
            child: Text('Su & İçecek'),
          ),
          Tab(
            child: Text('Tatlı'),
          ),
          Tab(
            child: Text('Yiyecek'),
          ),
          Tab(
            child: Text('Atıştırmalık'),
          ),
        ],
      ),
    ),

      body: BlocBuilder<HomeCubit,List<Foods>>(
        builder: (context,FoodsList){
          if(FoodsList.isNotEmpty){
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(width: 650,height: 650,
                child: GridView.builder(
                  shrinkWrap: true,
                  // reverse: true,
                   controller: controller,
                    itemCount: FoodsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 3.3,
                    crossAxisCount: 3),
                  itemBuilder: (context,index){
                    var foods = FoodsList[index];
                    return SizedBox(
                      child: GestureDetector(
                          onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  Details(food: foods)));
                        //       .then((value) {
                        //     context.read<HomeCubit>().getFoods();
                        //   });
                      },

                        child: Card(
                          child: Padding(

                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children:  [
                                   SizedBox(width: 50,height: 50,
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${foods.yemek_resim_adi}")),
                                Text("${foods.yemek_fiyat}₺",style: const TextStyle(fontSize: 10,color: Colors.redAccent,fontWeight: FontWeight.w300),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(foods.yemek_adi,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                ),
                                  const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      )
                    );
                    },
                ),
              ),
            );

          }
          else {
            return const Center();
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
        currentIndex: selectedIndex,
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
