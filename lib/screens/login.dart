import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child:Image.network("http://www.mobileswall.com/wp-content/uploads/2015/12/640-wWater-Drop-Reflection-l.jpg",
          fit: BoxFit.cover,),
        ),
        Center(
          child: MaterialButton(
            color: Colors.green,
            onPressed: null,
            child: Text('LOGIN',
            style: TextStyle(
              color: Colors.orange
            ),),
          ),
        )
      ],
    );
  }
}

