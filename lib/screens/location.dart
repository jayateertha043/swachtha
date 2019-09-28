import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:swachtha/screens/upload.dart';
import 'dart:convert';
import 'dart:io';

GoogleMapController mapController;

int i=0;

class LocationPage extends StatefulWidget {
  final File _image;
  LocationPage(this._image);
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationData currentLocation;
  var location = new Location();
   Set<Marker> m = Set();
  _addMarker(){
    
  } 
  
  Future<LocationData> _locate() async{
    location.changeSettings(
      accuracy: LocationAccuracy.HIGH,
    );
    LocationData currentLocationval = await location.getLocation();
    setState(() {
    currentLocation = currentLocationval;
    });
    return currentLocation;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Location'),
      ),
      body:
       Builder(
        builder: (context) => Stack(
          children: <Widget>[
            GoogleMap(
              markers: m,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                print("map created");
              },
            
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0,0.0),  
              ),
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,

            ),
            Container(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Text(currentLocation==null?'0.0':currentLocation.latitude.toString()),
                  ),
                  Card(
                    child: Text(currentLocation==null?'0.0':currentLocation.longitude.toString()),
                  ),
                  Card(
                    child: Text(currentLocation==null?'0.0':currentLocation.time.toString()),
                  )                                    
                ],
              ),
            ),
            Container(
        margin: EdgeInsets.all(10),      
        alignment: Alignment(0.9, 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'myLocation',
              onPressed: () async{
              await _locate();
              print("success "+ currentLocation.latitude.toString() + " " + currentLocation.longitude.toString() +" "+ currentLocation.time.toString());



                mapController?.moveCamera(
                CameraUpdate.newCameraPosition(
                CameraPosition(
                target: LatLng(currentLocation.latitude,currentLocation.longitude),
                zoom: 18.0,
                )));
                
              },
              child: Icon(Icons.location_searching),
              ),
              Container(
                height:3,
                width:0,
              ),
            FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                if(widget._image!=null){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Uploader(widget._image,currentLocation),
              ),
              );
              }
              },
              child: Icon(Icons.done),
            ),
          ]
        ),
      )
          ],
        ),
      ),
    );
  }
}

