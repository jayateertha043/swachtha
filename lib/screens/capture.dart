import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swachtha/screens/location.dart';
import 'package:swachtha/screens/logout.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ImageCapture extends StatefulWidget {
  FirebaseUser user;
  GoogleSignIn _googleSignIn;
  FirebaseAuth authu;
  ImageCapture(this.user,this.authu,this._googleSignIn);
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
    
    File _image;
    Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){

                 Navigator.push (context, MaterialPageRoute (builder: (context)=> Logout(widget.user,widget.authu,widget._googleSignIn)
                )
                );
      },
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Upload Image'),
        ),
        body: Stack(
          children: <Widget>[

          Container(
            
                  child: _image == null
              ? Text('\nNo Image Selected,Kindly follow the instructions to complete the procedure\n1.Take a picture by clicking on the camera Icon\n2.Once Image is captured click done')
              : Image.file(_image,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill),
        ),
        Container(
          alignment: Alignment(0.8, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'camera',
                onPressed: getImage,
                child: Icon(Icons.camera_alt),
                ),
                Container(
                  height:0,
                  width:2,
                ),
              FloatingActionButton(
                heroTag: 'next',
                onPressed: (){
                  if(_image!=null){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LocationPage(widget.user,widget.authu,widget._googleSignIn,_image),
                ),
                );
                }
                },
                child: Icon(Icons.done),
              ),
            ]
          ),
        )
        ,
          ]
      )
      ),
    );
      

  }
}