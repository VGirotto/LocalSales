import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {least_expensive, alphabetical_order, insertion_data}

class TesteBloc extends BlocBase {

  final _productsController = BehaviorSubject<List>();

  Stream<List> get outProducts => _productsController.stream;

  Firestore _firestore = Firestore.instance;

  List<DocumentSnapshot> _products = [];

  SortCriteria _criteria;

  TesteBloc(){
    _addProductsListener();
  }

  void _addProductsListener(){
    _firestore.collection("Produtos").document("Todos").collection("itens").snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change){
        String pid = change.document.documentID;

        switch(change.type){
          case DocumentChangeType.added:
            _products.add(change.document);
            break;
          case DocumentChangeType.modified:
            _products.removeWhere((product) => product.documentID == pid);
            _products.add(change.document);
            break;
          case DocumentChangeType.removed:
            _products.removeWhere((product) => product.documentID == pid);
            break;
        }
      });

      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria){
    _criteria = criteria;

    _sort();
  }

  void _sort(){
    print("hey");
    switch(_criteria){
      case SortCriteria.least_expensive:
        _products.sort((a,b){
          print("ola");
          double pa = a.data["price"];
          double pb = b.data["price"];
          if (pa < pb) return 1;
          else if (pa > pb) return -1;
          else return 0;
        });
        break;
      case SortCriteria.insertion_data:
        print("a");
        break;
      case SortCriteria.alphabetical_order:
        break;
    }
    _productsController.add(_products);
  }

  @override
  void dispose() {
    _productsController.close();
  }

}