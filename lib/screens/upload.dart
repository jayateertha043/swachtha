import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:location/location.dart';

class Uploader extends StatefulWidget {
  String durl;
  final File _image;
  LocationData currentLocation;
  Uploader(this._image,this.currentLocation);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://swachtha-36528.appspot.com/');
  final databaseReference = Firestore.instance;

  void createRecord() async {
  await databaseReference.collection("users")
      .document("0")
      .collection("data")
      .document()
      .setData({
        'latitude':'${widget.currentLocation.latitude.toString()}',
        'longitude': '${widget.currentLocation.longitude.toString()}',
        'timestamp' : '${widget.currentLocation.time.toString()}',
        'url' : '${widget.durl.toString()}',
      });
}

  Future<String> uploadPic() async {
    //Create a reference to the location you want to upload to in firebase  
    StorageReference reference = _storage.ref().child("users/admin/images/");
    //Upload the file to firebase 
    StorageUploadTask uploadTask = reference.putFile(widget._image);
    // Waits till the file is uploaded then stores the download url 
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    //returns the download url 
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    setState(() {
      widget.durl=url; 
    });
    return url;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Upload'),
      ),
      body:Container(
      child: Column(
      children: <Widget>[
        Card(
          child: Row(
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      height:50,
                      width:50,
                      child:Image.file(widget._image),
                    ),
                    Text(widget.currentLocation.latitude.toString() + "\n" +
                    widget.currentLocation.longitude.toString()
                    )
                  ],
                )
              ),
            ],
          ),
        ),
        FloatingActionButton(
          child: Text('Submit'),
                onPressed: () async{
                  await uploadPic();
                  print(widget.durl);
                  createRecord();
                  //now move to final screen and thanks etc
                } ,
              ),
              Text(widget.durl==null?'null':widget.durl)
      ],
    )) ,
    );
    
  }
}