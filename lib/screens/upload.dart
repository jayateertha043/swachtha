import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:swachtha/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swachtha/screens/capture.dart';


class Uploader extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseAuth authu;
  String value;
  FirebaseUser user;
  var load = false;
  String durl;
  final File _image;
  LocationData currentLocation;
  Uploader(this.user,this.authu,this._googleSignIn,this._image,this.currentLocation);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://swachtha-36528.appspot.com/');
  final databaseReference = Firestore.instance;

  void createRecord() async {
  await databaseReference.collection("users")
      .document("${widget.user.email}")
      .collection("data")
      .document()
      .setData({
        'name':'${widget.user.displayName}',
        'latitude':'${widget.currentLocation.latitude.toString()}',
        'longitude': '${widget.currentLocation.longitude.toString()}',
        'timestamp' : '${widget.currentLocation.time.toString()}',
        'url' : '${widget.durl.toString()}',
        'address': '${widget.value}',
      });
}

  Future<String> uploadPic() async {
    //Create a reference to the location you want to upload to in firebase  
    StorageReference reference = _storage.ref().child("users/${widget.user.email}/images/${widget.currentLocation.time.toString()}.jpg");
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
                  Container(
                    height:100,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                         widget.value = text;
                         print(widget.value);
                        });
                      },
            decoration: InputDecoration(
                labelText: 'Enter Address(optional)',
          )),
                  ),
        FloatingActionButton(
          child: Text('Submit'),
                onPressed: () async{
                  setState(() {
                   this.widget.load=true; 
                  });
                  await uploadPic();
                  print(widget.durl);
                  await createRecord();
                  setState(() {
                   this.widget.load=false; 
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageCapture(widget.user,widget.authu,widget._googleSignIn)));
                  //now move to final screen and thanks etc
                } ,
              ),
              Container(height:10,width:0),
              Loading(widget.load),
              Text(widget.durl==null?'':widget.durl + "\nSuccessfully registered Complaint ")
      ],
    )) ,
    );
    
  }
}