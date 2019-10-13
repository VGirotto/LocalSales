import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:local_sales/widgets/product_tile.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>{
  Icon _icone = new Icon(Icons.search);
  Widget _tituloAppBar = new Text( 'Produtos' );
  CollectionReference _firestore = Firestore.instance.collection("Produtos").document("Todos").collection("itens");
  Future<QuerySnapshot> _resultado = Firestore.instance.collection("Produtos").document("Todos").collection("itens").getDocuments();
  //Query where().firestore;

  @override
  Widget build(BuildContext context) {

    /*Query _filter(String search){
      setState(() {
        CollectionReference produtosFiltrados = this._firestore;

        this.saida = produtosFiltrados.where('itens.title', isEqualTo: search);  
      });
      /*CollectionReference produtosFiltrados = this._firestore;
      Query saida;

      saida = produtosFiltrados.where('itens.title', isEqualTo: search);*/
      
      return saida;
    }*/

    void onChangedSearch(String search){
      setState(() {
        if(search.trim().isEmpty){
          this._resultado = this._firestore.getDocuments();
          print("ok");
        }else{
          this._resultado = this._firestore.where('title', isEqualTo: search).getDocuments();
          print(search);
        }  
      });
    }

    void _searchPressed(){
      setState((){
        if(this._icone.icon == Icons.search){
          this._icone = new Icon(Icons.close);
          this._tituloAppBar = new TextField(
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Pesquisa...'
            ),
            onChanged: onChangedSearch
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
                    onPressed: _searchPressed
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
                future: _resultado,
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