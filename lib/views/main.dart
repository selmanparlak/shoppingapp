import 'package:final_project/cubit/home_cubit.dart';
import 'package:final_project/cubit/basket_cubit.dart';
import 'package:final_project/views/profile.dart';
import 'package:final_project/views/signup.dart';
import 'package:final_project/views/basket.dart';
import 'package:final_project/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
        //  BlocProvider(create: (context) => FoodBoxCubit()),
          BlocProvider(create: (context) => BasketCubit()),
        ],

    child: MaterialApp(
      routes: {
        '/home': (context) => const Home(),
        '/basket': (context) => const Basket(),
        '/profile': (context) => const Profile(),
        '/login': (context) => const LoginCon(),
      },
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:  const LoginCon(),
    ),
    );
  }
}

class LoginCon extends StatelessWidget {
  const LoginCon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
         } else if(snapshot.hasError)
            {
              return const Center(child: Text("Hata'!"),);
            }else if (snapshot.hasData){
                return const Home();

              }
          else {
            return  const AuthPage();
          }
        }
      ),
    );

  }
}

