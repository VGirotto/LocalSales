import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String category;
  String id;
  String title;
  String description;
  double price;
  int amount;
  List images;
  List size;
  String salesperson;
  String uid;
  String categoria; //essa é o atributo

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title  = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"]+0.0;
    images = snapshot.data["images"];
    amount = snapshot.data["amount"];
    salesperson = snapshot.data["vendedor"];
    uid = snapshot.data["uid"];
    categoria = snapshot.data["categoria"];
  }
}