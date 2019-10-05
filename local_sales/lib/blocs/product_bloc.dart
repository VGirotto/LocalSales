import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {

  final _dataController = BehaviorSubject<Map>();
  Stream<Map> get outData => _dataController.stream;

  String categoriaID;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData;

  ProductBloc({this.categoriaID, this.product}){
    if(product != null){
      unsavedData = Map.of(product.data);
      unsavedData['images'] = List.of(product.data["images"]);
    } else {
      unsavedData = {
        "title": null, "description": null, "price": null, "images": [], "amount": null, "name": null,
      };
    }
    _dataController.add(unsavedData);

  }

  void saveTitle(String tittle){
    unsavedData["tittle"] = tittle;
  }
  void saveDescription(String description){
    unsavedData["descripition"] = description;
  }
  void savePrice(String price){
    unsavedData["price"] = double.parse(price);
  }
  void saveAmount(String amount){
    unsavedData["amount"] = int.parse(amount);
  }
  void saveImages(List images){
    unsavedData["images"] = images;
  }


  @override
  void dispose(){
    _dataController.close();
  }
}