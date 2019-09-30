import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swachtha/screens/login.dart';
import 'package:swachtha/screens/capture.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Logout extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseAuth authu;
  FirebaseUser user;
  Logout(this.user,this.authu,this._googleSignIn);
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('Logout or Continue'),),

  body: Column(children: <Widget>[Center(child: Container(height:250,width:0)),Image.network(widget.user.photoUrl),SizedBox(height: 20,),
              Text(widget.user.email),
              MaterialButton(
                color: Colors.green,
                child: Text('Continue'),
                onPressed: () {
                 Navigator.push (context, MaterialPageRoute (builder: (context)=>ImageCapture(widget.user,widget.authu,widget._googleSignIn)
                )
                );
                },
              ),
              MaterialButton(
                color: Colors.red,
                child: Text('LogOut'),
                onPressed:() async {
                  await widget.authu.signOut();
                  await widget._googleSignIn.disconnect();
                  Navigator.push (context, MaterialPageRoute (builder: (context) =>LoginPage()));   
                }
              ),
              ],
              ),
    );
  }
}