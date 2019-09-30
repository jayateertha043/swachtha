import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swachtha/screens/capture.dart';



String title ='Change the Title';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _login(BuildContext context) async{
    try{
      GoogleSignInAccount account =   await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await account.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

      final FirebaseUser users = (await _auth.signInWithCredential(credential)).user;
      print(users);
      setState(() {
        isLoggedIn = true;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageCapture(users,_auth,_googleSignIn)));
    } catch (err){
      print(err);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Text('Login')
        ),

        body: Center(
            child: isLoggedIn
            ?Container()
            :Center(
                    child: OutlineButton(
                      child: Text("Login with Google"),
                      onPressed: () {
                        _login(context);
                      },
                    ),
                  )),
      ),
    );
  }
}

