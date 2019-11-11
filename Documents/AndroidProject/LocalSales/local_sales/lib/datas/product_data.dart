
class ProductData{
  String category;
  //String id;
  String title;
  String description;
  double price;
  int amount;
  List images;
  List size;
  String salesperson;
  String uid;
  String categoria; //essa é o atributo

  ProductData.fromDocument(dynamic snapshot){
    //id = snapshot;
    title  = snapshot["title"];
    description = snapshot["description"];
    price = snapshot["price"]+0.0;
    images = snapshot["images"];
    amount = snapshot["amount"];
    salesperson = snapshot["vendedor"];
    uid = snapshot["uid"];
    categoria = snapshot["categoria"];
  }
}