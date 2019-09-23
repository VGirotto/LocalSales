<<<<<<< HEAD
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
            HomeTab(),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top:100),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10.0,
                      color:Colors.transparent,
                    ),
                  ),
                  FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance.collection("Israel").getDocuments(),       ///trocar Israel Pela Colecao
                    builder:(context, snapshot){
                      if (!snapshot.hasData)
                        return SliverToBoxAdapter(
                          child: Container(
                            height:50,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                            ),
                          ),
                        );
                      else
                        return SliverStaggeredGrid.count(
                          crossAxisCount:1,
                          mainAxisSpacing:50,
                          staggeredTiles: snapshot.data.documents.map(
                                (doc){
                              return StaggeredTile.count(1,1);
                            },
                          ).toList(),
                          children: snapshot.data.documents.map(
                                  (doc){
                                return Container(
                                    child: Column(
                                    children: <Widget>[
                                      Container(

                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: Colors.grey,
                                            ),

                                            borderRadius:BorderRadius.all(Radius.circular(5.0),),
                                          ),
                                          child:FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: doc.data["image"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text("Olasas"),
                                      ),

                                      /*
                                      Positioned.fill(
                                        child: FractionallySizedBox(
                                          heightFactor:0.3,
                                          alignment: Alignment.bottomCenter,
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(5.0),),),
                                                  child: _buildBodyText(),
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  child:
                                                  SingleChildScrollView(
                                                    child:
                                                    Text(doc.data["msg"].toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,


                                                        fontSize: 14,
                                                        fontStyle: FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      */

                                    ],
                                  ),




                                );
                              }
                          ).toList(),
                        );
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      onRefresh: refresh,
      ),
    );
  }
=======
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
>>>>>>> Augusto
}