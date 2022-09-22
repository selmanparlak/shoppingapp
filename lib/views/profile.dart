import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfafafa),
      elevation: 0,
      title: const Center(child: Text("Profil",style: TextStyle(color: Colors.black),)),
      automaticallyImplyLeading: false,
      actions: [
        /*
        IconButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, '/login');
    },icon: const Icon(Icons.logout))
         */
      ],
      ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children:  [
            Image.asset("img/man.png"),
            SizedBox(height: 10,),
            const Text('Ad Soyad',
            style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),
            ),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 16,),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView(
                    children:  <Widget>[
                      const ProfileListItem(
                        icon: Icons.person,
                        text: 'Hesabım',
                      ),
                      const ProfileListItem(
                        icon: Icons.location_on,
                        text: 'Adreslerim',
                      ),
                      const ProfileListItem(
                        icon: Icons.access_time_filled_outlined,
                        text: 'Geçmiş Siparişlerim',
                      ),
                      const ProfileListItem(
                        icon: Icons.payment,
                        text: 'Ödeme Yöntemlerim',
                      ),
                      const ProfileListItem(
                        icon: Icons.notifications,
                        text: 'İletişim Ayarları',
                      ),

                      const ProfileListItem(
                        icon: Icons.help,
                        text: 'Canlı Destek',
                      ),
                      GestureDetector(
                        onTap: (){
                        //  FirebaseAuth.instance.signOut();
                        //  Navigator.pushNamed(context, '/login');
                        },
                        child: const ProfileListItem(
                          icon: Icons.logout,
                          text: 'Çıkış',
                        ),
                      ),
                    ]
                  ),
                )
            )
          ],
        ),
      ),
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
          currentIndex: 2,
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
class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
 // final bool hasNavigation;
  const ProfileListItem({
    Key? key, required this.icon, this.text,}) : super(key: key
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:50),
      child: Padding(
        padding: const EdgeInsets.only(top:10),
        child: Ink(
          height: 50,
          //margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                size: 16,
              ),
              const SizedBox(width: 25,),
              Text(this.text),
              Spacer(),
                 IconButton(
                   splashRadius: 20,
                  icon: const Icon(Icons.keyboard_arrow_right),
                   onPressed: () {
                     if(this.text=="Çıkış")
                       {
                         FirebaseAuth.instance.signOut();
                         Navigator.pushNamed(context, '/login');
                       }
                   },
                ),

            ],
          ),
        ),
      ),
    );
  }
}
