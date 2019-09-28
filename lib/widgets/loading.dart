import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  var _load;
  Loading(this._load);
  Widget build (BuildContext context) {

       return (_load == true) ? new CircularProgressIndicator() : Container(height: 0,width: 0,);
  }
}
