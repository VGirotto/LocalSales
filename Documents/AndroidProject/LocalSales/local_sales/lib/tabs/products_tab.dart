import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/widgets/category_tile.dart';
import 'dart:core';

class ProductsTab extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("Produtos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else {
          var dividedTiles = ListTile.divideTiles(
              context: context,
              tiles: snapshot.data.documents.map((doc) {
                return CategoryTile(doc);
              }).toList(),
              color: Colors.grey[500])
              .toList();
          dividedTiles.removeLast();
          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
