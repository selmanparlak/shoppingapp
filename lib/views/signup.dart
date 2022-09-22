import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
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
        appBar: AppBar(automaticallyImplyLeading: false,backgroundColor: const Color(0xFFfafafa),elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Form(
              key: formKey,
            child: Column(
              children: [
                SizedBox(width: 128,height: 128,
                    child: Image.asset("img/online-shopping.png")),
                const Text("Hey sen, Aramıza Katıl",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: SizedBox(width: 300,height: 150,
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color:Colors.white ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(hintText: 'Email',border: InputBorder.none),
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                       ? 'Geçerli bir mail adresi giriniz.'
                                        : null,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color:Colors.white ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(hintText: 'Sifre',border: InputBorder.none),
                            obscureText: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (password) =>
                            password != null && password.length < 6
                                ? '6 Karakterli şifre giriniz.'
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 150,height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size.fromHeight(1),

                      ),
                      icon: const Icon(Icons.login,size: 24,),
                      label: const Text(
                        'Üye Ol',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: signUp,
                    ),


                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text:   TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
                        text: 'Giriş Yap',
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
          ),
        )
    );
  }
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }on FirebaseAuthException catch(e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    }
  }

class Utils {
   static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text){
    if(text == null)return;

    final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.red);

    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
}

