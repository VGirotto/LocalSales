import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import '';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
 //////////////////////Background Degrade/////////////////////
    Widget _buildDegrade() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
////////////////////////////////////////////////////////////////

    return Stack(
        children: <Widget>[
          _buildDegrade(),
          CustomScrollView(
            slivers: <Widget>[
              FutureBuilder<QuerySnapshot>(
                future: Firestore.instance.collection("Produtos").getDocuments(),
                builder: (context, snapshot){
                  if(!snapshot.hasData)
                    return SliverToBoxAdapter();
                }
              ),
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Category", style: TextStyle(color: Colors.black,),),
                  centerTitle: true,
                )
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      child:Row(
                        children: <Widget>[
                          Container(
                            height:110,
                            width: 110,
                            margin: EdgeInsets.only(left: 20, top: 25),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/teste.jpg'),
                              ),
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.only(top:20),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width:250,
                                  height:80,
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
                    ),
                    Container(
                      child:Row(
                        children: <Widget>[
                          Container(
                            height:110,
                            width: 110,
                            margin: EdgeInsets.only(left: 20, top: 25),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/teste.jpg'),
                              ),
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.only(top:20),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width:250,
                                  height:80,
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
                    ),Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                          height:110,
                          width: 110,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/teste.jpg'),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(top:20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width:250,
                                height:80,
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
                  ),Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                          height:110,
                          width: 110,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/teste.jpg'),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(top:20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width:250,
                                height:80,
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
                  ),Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                          height:110,
                          width: 110,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/teste.jpg'),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(top:20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width:250,
                                height:80,
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
                                      color: Colors.white,
                                      fontSize: 12,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                          height:110,
                          width: 110,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/teste.jpg'),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(top:20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width:250,
                                height:80,
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
                                      color: Colors.white,
                                      fontSize: 12,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),Container(
                    child:Row(
                      children: <Widget>[
                        Container(
                          height:110,
                          width: 110,
                          margin: EdgeInsets.only(left: 20, top: 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/teste.jpg'),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(top:20),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width:250,
                                height:80,
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
                                      color: Colors.white,
                                      fontSize: 12,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),



                  ],
                ),
              ),










/*
              FutureBuilder<QuerySnapshot>(        ///funcao de carregamento do pacore firestore
                future> Firestore.instance.collection("home").orderBy("pos").getDocuments(),  ///home: bd, pos: modo de ordenacao
                builder: (context, snapshot){
                  if(!snapshot.hashData)
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alingment: Alingment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  else{
                    print(snapshot.data.documents.length);
     //////////////////////////////////////////////////////////
                    return SliverList(
                      delegate: SliverChildDelegate([
                        Container()




                      ])








                    );
    ///////////////////////////////////////////////////////////


                  }
                }
              )
*/

            ],
          ),
        ],
    );
  }
}