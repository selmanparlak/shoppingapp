
import 'package:final_project/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              SizedBox(width: 128,height: 128,
                  child: Image.asset("img/online-shopping.png")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: SizedBox(width: 300,height: 150,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color:Colors.white ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(hintText: 'Email',border: InputBorder.none),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(hintText: 'Sifre',border: InputBorder.none),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 150,height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size.fromHeight(1),

                  ),
                  icon: const Icon(Icons.login,size: 24,),
                  label: const Text(
                    'Giriş Yap',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: signIn,
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RichText(
                    text:   TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                      text: 'Üye Ol',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ),

                ),
              )
            ],
          ),
        ),
      )
    );

  }
  Future signIn() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch (e){
      print(e);
      Utils.showSnackBar(e.message);

    }

  }
}
