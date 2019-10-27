import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:local_sales/screens/cadastroProduto_screen.dart';
import 'package:local_sales/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;
  final _validation;
  //final DocumentSnapshot produtoSnap;
  ProductTile(this.type, this.product, this._validation/*, this.produtoSnap*/);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /*onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(           
            builder: (context)=>(_validation == 0)?ProductScreen(product):cadastroProduto(categoriaID: product.categoria, product: produtoSnap),
          )
        );
      },*/
        child: Card(
            child: type == "grid"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 0.8,
                        child: Image.network(
                          product.images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                product.title,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "R\$ ${product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    height: 250.0,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "R\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                )
              ],
            )
        )
    );
  }
}
