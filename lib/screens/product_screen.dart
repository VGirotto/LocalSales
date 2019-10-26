import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:local_sales/tabs/chat_tab.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

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
                        child: Text(
                          "Vendedor(a): " + product.salesperson.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return RaisedButton(
                              color: Colors.deepOrange,
                              onPressed: () {
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

}