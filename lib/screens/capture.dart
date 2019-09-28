import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swachtha/screens/location.dart';

class ImageCapture extends StatefulWidget {
  FirebaseUser user;
  ImageCapture(this.user);
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
    return Scaffold(
      appBar: AppBar(
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
                builder: (context) => LocationPage(widget.user,_image),
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
    );
      

  }
}