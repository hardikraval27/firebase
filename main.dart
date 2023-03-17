import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'messageging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: message(),
  ));
}

class hhh extends StatefulWidget {
  const hhh({Key? key}) : super(key: key);

  @override
  State<hhh> createState() => _hhhState();
}

class _hhhState extends State<hhh> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool yy = false;
  bool xx = false;

  bool hardik=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Firebase")),
      ),
      body: Column(
        children: [Container(height: 300,width: 300,   child: Lottie.asset("animation/animation1.json"),),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: TextField(
                controller: email,
                decoration: InputDecoration(
                    errorText: yy ? "email" : null,
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),onChanged:(value) {
              if(value!=""){

                setState(() {
                  yy=false;
                });
              }
                        },),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, right: 10, left: 10),
            child: TextField(
                controller: password,
                decoration: InputDecoration(suffixIcon: IconButton(onPressed: () {
                   setState(() {
                     hardik=!hardik;
                   });
                }, icon: Icon(Icons.remove_red_eye)),
                    errorText: xx ? "password" : null,
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),onChanged: (value) {
                          if(value!=""){

                            setState(() {
                              xx=false;
                            });
                          }
                        },obscureText: hardik,
            obscuringCharacter: "*",),

          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );

                  if (email.text == "") {
                    setState(() {
                      yy = true;
                    });
                  } else if (password.text == "") {
                    setState(() {
                      xx = true;
                    });
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Login")),
          ElevatedButton(
              onPressed: () async {

                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return fireotp();
                // },));
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text("Register")),
        ],
      ),
    );
  }
}
