import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swachtha/screens/login.dart';
void main(){
  SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
  }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'swachtha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage() ,
    );
  }
}
