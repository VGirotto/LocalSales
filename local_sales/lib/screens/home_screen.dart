import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:local_sales/tabs/home_tab.dart';
import 'dart:async';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}



Widget _buildBodyText() => Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(122, 122, 122, 0.4),
          Color.fromRGBO(122, 122, 122, 0.8),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )
  ),
);



Future<Null> refresh() async{

  Completer<Null> completer = Completer<Null>();
  await Future.delayed(Duration(seconds: 1)).then((_){
    completer.complete();
  });

  return completer.future;
}


Widget homeList(AsyncSnapshot snapshot, int index){
  return snapshot.data.documents().map<Widget>((document){
    return Container(
      child:Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: snapshot.data["image"],
              ),
            ),
          ),

          Container(
            margin:EdgeInsets.only(top:20),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Opacity(
                    opacity:0.2,
                    child: Container(
                      color:Colors.black,
                    ),
                  ),
                ),
                Container(
                  color:Colors.transparent,
                  child: Text("inputDescription. Loren ipsun",
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList(index);
}


class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Stack(
          children: <Widget>[


          ],
        ),

      ),
    );
  }
}