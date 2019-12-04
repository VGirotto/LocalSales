import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:local_sales/tabs/chat_tab.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'vendedor_screen.dart';


class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  _ProductScreenState(this.product);

  List users = new List();
  List users2 = new List();
  Map<String, dynamic> usuarios;
  Map<String, dynamic> usuarios2;
 

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.9,
                child: Carousel(
                    images: product.images.map((url) {
                      return NetworkImage(url);
                    }).toList(),
                    dotSize: 4.0,
                    dotSpacing: 10.0,
                    dotBgColor: Colors.transparent,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Colors.deepOrange,
                    autoplay: false),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      child: Text(
                        product.title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                        child: Text(
                          "Descrição",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                        child: Text(product.description,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500
                          ),
                        )

                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Text(
                          "Quantidade Disponível: " + product.amount.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: Firestore.instance.collection("users").document(product.uid).get(),
                          builder: (context, snapshot) {
                            return Text(
                                  "Vendedor(a): " + snapshot.data["name"],
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300
                                  ),
                                );
                          },
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 140.0, 0.0),
                        child: RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(           
                                builder: (context)=>VendedorScreen(product),
                              )
                            );
                          },
                          child: Text("Acessar Perfil do Vendedor",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                                fontSize: 12.0
                            ),
                          ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return RaisedButton(
                              color: Colors.orange,
                              onPressed: () async {

                                    bool jaExiste = false;

                                    //          Salva o id do usuário atual na lista do vendedor

                                    DocumentSnapshot docUser =
                                    await Firestore.instance.collection("users").document(product.uid).get();  //pega informações do vendedor

                                    usuarios = Map.of(docUser.data);
                                    users = List.of(docUser.data["conversou"]);  //pega as informações

                                    for(int i = 0; i < users.length; i++){    //verifica se o id já existe na lista
                                      if(users[i] == model.firebaseUser.uid)
                                          jaExiste = true;
                                    }
                                    
                                    if(jaExiste == false){  //se o id não existe, então salva os dois ids já

                                      users.add(model.firebaseUser.uid);
                                      saveUsers(users);   //atualiza as informações

                                      Firestore.instance.collection('users')    //coloca no firebase
                                      .document(product.uid)
                                      .updateData(usuarios);
                                    

                                      //          Salva o id do vendedor na lista do usuário atual

                                      docUser =
                                      await Firestore.instance.collection("users").document(model.firebaseUser.uid).get();  //pega informações do usuário atual

                                      usuarios2 = Map.of(model.userData);
                                      users2 = List.of(docUser.data["conversou"]);  //pega as informações
                                      
                                      
                                      users2.add(product.uid);
                                      saveUsers2(users2);   //atualiza as informações

                                      Firestore.instance.collection('users')    //coloca no firebase
                                      .document(model.firebaseUser.uid)
                                      .updateData(usuarios2);
                                    }


                                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Chat(
                                          peerId: product.uid,
                                          peerAvatar: null,
                                          namePressed: product.salesperson,
                                          id: model.firebaseUser.uid,
                                        )
                                ));
                              },
                              child: Text("Falar com Vendedor(a)",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,
                                    fontSize: 18.0
                                ),
                              ),
                            );
                          }
                          )
                    )],
                ),
              )
            ],
          )
      ),
    );
  }

  void saveUsers2(List users) {
    usuarios2["conversou"] = users;
  }

  void saveUsers(List users) {
    usuarios["conversou"] = users;
  }

}