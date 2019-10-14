import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_sales/widgets/product_tile.dart';


class UserDocument{

  getDocument(){
    String user = 'Fulano';                                     ///put name here
    String _user = user;
    return Firestore.instance.collection("Produtos").
    document("Salgados").collection("itens").
    where('vendedor', isEqualTo:_user ).
    getDocuments();
  }
}





class LogTab extends StatelessWidget {
  LogTab();

  @override
  Widget build(BuildContext context) {
    CollectionReference _firestore = Firestore.instance.collection("Produtos").document("Todos").collection("itens");
    Future<QuerySnapshot> _resultado = UserDocument().getDocument();

    return DefaultTabController(
          length: 1,
          child: Scaffold(

            body: FutureBuilder<QuerySnapshot>(
              future: _resultado,
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(),);
                else
                  return TabBarView(
                    children: [

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
        );


  }
}