import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:local_sales/widgets/product_tile.dart';



class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class /*HomeTab*/_HomeTabState extends State<HomeTab>/*StatelessWidget*/ {
  Icon _icone = new Icon(Icons.search);
  Widget _tituloAppBar = new Text( 'Produtos' );

  @override
  Widget build(BuildContext context) {

    void _searchPressed(){
      setState((){
        if(this._icone.icon == Icons.search){
          this._icone = new Icon(Icons.close);
          this._tituloAppBar = new TextField(
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
            ),
          );
        }else{
          this._icone = new Icon(Icons.search);
          this._tituloAppBar = new Text("Produtos");
        }
      });
    }

    return
      Stack(
        children: <Widget>[


          DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: Container(color: Colors.orange),
                actions: <Widget>[
                  IconButton(
                      icon: _icone,
                      onPressed: (){
                        setState((){
                          if(this._icone.icon == Icons.search){
                            this._icone = new Icon(Icons.close);
                            this._tituloAppBar = new TextField(
                              decoration: new InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                                  suffixIcon: new Icon(Icons.search, color: Colors.black),
                                  hintText: 'Pesquisa...'
                              ),
                            );
                          }else{
                            this._icone = new Icon(Icons.search);
                            this._tituloAppBar = new Text("Produtos");
                          }
                        });
                      }
                  )
                ],
                title: _tituloAppBar,
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.grid_on,),),
                    Tab(icon: Icon(Icons.list,),),
                  ],
                ),
              ),
              body: FutureBuilder<QuerySnapshot>(
                future: Firestore.instance.collection("Produtos").document("Todos").collection("itens").getDocuments(),
                builder: (context, snapshot){
                  if(!snapshot.hasData)
                    return Center(child: CircularProgressIndicator(),);
                  else
                    return TabBarView(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 0.65,
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            return ProductTile("grid", ProductData.fromDocument(snapshot.data.documents[index]));
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            return ProductTile("list", ProductData.fromDocument(snapshot.data.documents[index]),);
                          }
                        ),
                      ],
                    );
                },
              ),
            ),
          ),
          Container(
            height:110,
            width:110,
            child:CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),

        ],
      );
    //onRefresh: refresh;
  }
}