import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:local_sales/widgets/product_tile.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Icon _icone = new Icon(Icons.search);
  Widget _tituloAppBar = new Text('Produtos');
  CollectionReference _firestore = Firestore.instance
      .collection("Produtos")
      .document("Todos")
      .collection("itens");
  Future<QuerySnapshot> _resultado = Firestore.instance
      .collection("Produtos")
      .document("Todos")
      .collection("itens")
      .getDocuments();
  List<String> names;
  Future<QuerySnapshot> documentsp;

  ProductData product;
  String aux;

  TextEditingController textobusca = new TextEditingController();
  int controle = 0;

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

    Future onChangedSearch(String search) {
      setState(() {
        if (search.trim().isEmpty) {
          this._resultado = this._firestore.getDocuments();
          print("ok");
        } else {
          List<DocumentSnapshot> snapshotss = List();

          this._resultado = this._firestore.getDocuments();

          //Stream<QuerySnapshot> documents = this._resultado.asStream();

          //documents.forEach((snapshot) => {
           //     snapshot.documents.forEach((doc) => {
             //         if (doc.data['title']
               //           .toLowerCase()
                 //         .contains(search.toLowerCase()))
                   //     print("sim para ${doc.data['title']}")
                    //})
              //});

          //this._resultado = snapshotss as Future<QuerySnapshot>;
          //print(snapshotss[0].data['title']);
        }
      });
    }

    void _searchPressed() {
      setState(() {
        if (this._icone.icon == Icons.search) {
          this.controle = 1;
          print(textobusca.toString());
          this._icone = new Icon(Icons.close);
          this._tituloAppBar = new TextField(
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search), hintText: 'Pesquisa...'),
              onChanged: onChangedSearch,
              controller: textobusca,);
        } else {
          print(textobusca.toString());
          this.controle = 0;
          this._icone = new Icon(Icons.search);
          this._tituloAppBar = new Text("Produtos");
        }
      });
    }



    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: Container(color: Colors.orange),
              actions: <Widget>[
                IconButton(icon: _icone, onPressed: _searchPressed)
              ],
              title: _tituloAppBar,
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.grid_on,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.list,
                    ),
                  ),
                ],
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: _resultado,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else{

                  int uso = 0;
                  int uso2 = 0;

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
                        itemBuilder: (context, index) {

                          if(controle == 1){

                            if(uso < snapshot.data.documents.length) {
                            while(uso < snapshot.data.documents.length && snapshot.data.documents[uso].data['title'].toLowerCase().contains(textobusca.text.toLowerCase()) == false) {

                                  uso = uso + 1;
                                  if(uso == snapshot.data.documents.length)
                                    return Container();
                            }

                              if(snapshot.data.documents[uso].data['title'].toLowerCase().contains(textobusca.text.toLowerCase()) != false){
                                uso2 = uso;
                                uso = uso+1;

                                return ProductTile("grid",
                                    ProductData.fromDocument(
                                        snapshot.data.documents[uso2]), 0,
                                    snapshot.data.documents[uso2]);
                              }
                              else
                                return Container();
                          }

                            else
                              return Container();

                          }
                          else {
                            return ProductTile("grid", ProductData.fromDocument(snapshot.data.documents[index]), 0, snapshot.data.documents[index]);
                          }
                        },
                      ),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            if(controle == 1){
                              if(snapshot.data.documents[index].data['title'].toLowerCase().contains(textobusca.text.toLowerCase()) != false ){
                                return ProductTile("list",ProductData.fromDocument(snapshot.data.documents[index]), 0, snapshot.data.documents[index]);
                              }

                              else
                                return Container();

                            }
                            else {
                              return ProductTile("list", ProductData.fromDocument(snapshot.data.documents[index]), 0, snapshot.data.documents[index]);
                            }
                          }),
                    ],
                  );}
              },
            ),
          ),
        ),
        Container(
          height: 110,
          width: 110,
          child: CustomScrollView(
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
