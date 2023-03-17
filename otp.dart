import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class fireotp extends StatefulWidget {
  const fireotp({Key? key}) : super(key: key);

  @override
  State<fireotp> createState() => _fireotpState();
}
class _fireotpState extends State<fireotp> {

  TextEditingController nn=TextEditingController();
  TextEditingController vv=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(margin: EdgeInsets.only(top: 10,right: 10,left: 10),
            child: TextField(controller: nn,
                decoration: InputDecoration(
                    hintText: "Mbnumber",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
          Container(margin: EdgeInsets.only(top: 80,right: 10,left: 10),
            child: TextField(controller: vv,
                decoration: InputDecoration(
                    hintText: "otp",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ),
          ElevatedButton(onPressed: () async {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91${nn.text}',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {},
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
            signInWithGoogle();
            // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vv.text, smsCode: nn.text);
            //
            // // Sign the user in (or link) with the credential
            // await auth.signInWithCredential(credential);
          }, child: Text("otp"))
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
