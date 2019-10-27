import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/widgets/product_tile.dart';
import 'package:scoped_model/scoped_model.dart';


class UserDocument{
  String user;
  getDocument(){
    ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        user = model.firebaseUser.uid;
        print(user);
        }
    );
    print(user);
    return Firestore.instance.collection("Produtos").
        document("Todos").collection("itens").
        where('uid', isEqualTo:user ).getDocuments();
  }
}





class LogTab extends StatelessWidget {
  LogTab();

  @override
  Widget build(BuildContext context) {
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
                            return ProductTile("list", ProductData.fromDocument(snapshot.data.documents[index]), 1, /*snapshot.data.documents[index]*/);
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